# Import Flask Library
from flask import Flask, render_template, request, session, url_for, redirect, flash
import pymysql.cursors

# A library included within flask for hashing
from werkzeug.security import generate_password_hash, check_password_hash

# Initialize the app from Flask
app = Flask(__name__)
app.secret_key = 'some key that you will never guess'

# Configure MySQL
conn = pymysql.connect(host='localhost',
                       port=8889,
                       user='root',
                       password='root',
                       db='Roomio',
                       charset='utf8mb4',
                       cursorclass=pymysql.cursors.DictCursor)

# Define a route to hello function
@app.route('/')
def hello():
    return render_template('landing.html')

#Define route for login
@app.route('/login')
def login():
    return render_template('login.html')

# Define route for register
@app.route('/register')
def register():
    return render_template('register.html')

# Authenticates the login
@app.route('/loginAuth', methods=['GET', 'POST'])
def loginAuth():
    # Request data
    username = request.form['username']
    password = request.form['password']

    # Get hash from DB
    cursor = conn.cursor()
    query = 'SELECT passwd FROM Users WHERE username = %s'
    cursor.execute(query, (username))
    data = cursor.fetchone()
    cursor.close()

    # Compare hash from DB with provided plaintext
    if data and check_password_hash(data["passwd"], password):
        # Success
        session['username'] = username
        return redirect(url_for('home'))
    else:
        # Failure
        error = 'Invalid login or username'
        return render_template('login.html', error=error)

# Authenticates the register
@app.route('/registerAuth', methods=['GET', 'POST'])
def registerAuth():
    # Request data
    username = request.form['username']
    passwd = request.form['password']
    first_name = request.form['firstname']
    last_name = request.form['lastname']
    DOB = request.form['birthday']
    gender = request.form['gender']
    Phone = request.form['phone']
    email = request.form['email']

    # Check for pre-existing users
    cursor = conn.cursor()
    query = 'SELECT * FROM Users WHERE username = %s'
    cursor.execute(query, (username))
    data = cursor.fetchone()

    if data:
        # Found pre-existing account
        error = "This user already exists"
        return render_template('register.html', error=error)
    else:
        # Generate hash and insert new user into DB
        passwd = generate_password_hash(passwd)
        ins = 'INSERT INTO Users VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (username, first_name, last_name, DOB, gender, Phone, email, passwd))
        conn.commit()
        cursor.close()
        return render_template('landing.html')

# Takes user to homepage upon login
@app.route('/home')
def home():
    # Reset Session Variables
    user = session['username']
    session['error'] = None
    session['unitID'] = None
    session['comp'] = None
    session['build'] = None
    session['PetName'] = None
    session['PetType'] = None
    return render_template('home.html', username=user)

# Search page for finding listings
@app.route('/viewListings',methods=['GET', 'POST'])
def viewListings():
    # Get data
    user = session['username']
    error = session['error']

    # Get list of buildings with units for rent
    cursor = conn.cursor()
    query = "SELECT CompanyName,BuildingName,AddrNum,AddrStreet,AddrCity,AddrState,AddrZipCode,YearBuilt,COUNT(UnitRentID) AS Units FROM ApartmentBuilding JOIN ApartmentUnit USING(CompanyName, BuildingName) GROUP BY CompanyName,BuildingName"
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()
    return render_template('listingmain.html', username=user, posts=data, error=error, mode = None)

# Performs a search for units requested by the user
@app.route('/searchListings', methods=['GET', 'POST'])
def searchListings():
    # Get data
    user = session['username']
    # First time approaching
    try:
        comp = request.form['company']
        build = request.form['building']
        session['comp'] = comp
        session['build'] = build
        session['error'] = None
    # Returning from an error
    except:
        comp = session['comp']
        build = session['build']

    # Get listings from specific building
    cursor = conn.cursor()
    query = "SELECT UnitRentID, CompanyName, BuildingName, unitNumber,MonthlyRent,squareFootage,AvailableDateForMoveIn,BedroomCount,BathroomCount FROM ApartmentUnit NATURAL JOIN bathcounter NATURAL JOIN bedcounter WHERE CompanyName=%s AND BuildingName=%s GROUP BY UnitRentID ORDER BY UnitRentID;"
    cursor.execute(query, (comp,build))
    data = cursor.fetchall()

    if data:
        # Compare building's policy with user's pets
        query ="SELECT PetName, PetType, PetSize, isAllowed, RegistrationFee, MonthlyFee FROM Pets JOIN PetPolicy USING(PetType, PetSize) WHERE username = %s AND CompanyName = %s AND BuildingName = %s"
        cursor.execute(query, (user,comp, build))
        data2 = cursor.fetchall()
        cursor.close()
        return render_template('listingmain.html', username=user, posts=data, posts2=data2, error=None, mode='Search')
    else:
        # Failure to find building
        session['error'] = 'No results matching parameters found'
        cursor.close()
        return redirect(url_for('viewListings'))

# Views a specific unit selected by the user
@app.route('/viewUnit', methods=['GET', 'POST'])
def viewUnit():
    # Get data
    user = session['username']
    # First time approaching
    try:
        unit = request.form['unitID']
        comp = request.form['comp']
        build = request.form['build']
        session['unitID'] = unit
        session['comp'] = comp
        session['build'] = build
        session['error'] = None
        error = None
    # Returning from error
    except:
        unit = session['unitID']
        comp = session['comp']
        build = session['build']
        error = session['error']

    # cursor used to send queries
    cursor = conn.cursor()

    # Unit data
    query = 'SELECT * FROM ApartmentUnit NATURAL JOIN ApartmentBuilding NATURAL JOIN bedcounter NATURAL JOIN bathcounter WHERE UnitRentID =%s'
    cursor.execute(query, (unit))
    data = cursor.fetchone()

    # Room data
    query = 'SELECT name,squareFootage,description FROM Rooms WHERE UnitRentID =%s'
    cursor.execute(query, (unit))
    rooms = cursor.fetchall()

    # Unit amenities
    query = 'SELECT aType,Description FROM AmenitiesIn NATURAL JOIN Amenities WHERE UnitRentID =%s'
    cursor.execute(query, (unit))
    uamen = cursor.fetchall()

    # Building amenities
    query = 'SELECT aType,Description, Fee, waitingList FROM Provides NATURAL JOIN Amenities WHERE CompanyName=%s AND BuildingName=%s'
    cursor.execute(query, (comp,build))
    bamen = cursor.fetchall()

    # Interest in unit
    query = 'SELECT username,RoommateCnt,MoveInDate FROM Interests WHERE UnitRentID = %s ORDER BY MoveInDate'
    cursor.execute(query, (unit))
    inter = cursor.fetchall()

    # Interest in unit
    query = 'SELECT PetType,PetSize,isAllowed,RegistrationFee,MonthlyFee FROM PetPolicy WHERE CompanyName=%s AND BuildingName=%s ORDER BY PetType,PetSize'
    cursor.execute(query, (comp,build))
    policy = cursor.fetchall()

    cursor.close()
    return render_template('unitview.html', username=user, posts=data, posts1=rooms,posts2=uamen,posts3=bamen,posts4=inter, posts5=policy, error = error)
@app.route('/makeInterest', methods=['GET', 'POST'])
def makeInterest():
    # Get data
    user = session['username']
    unit = request.form['unitID']
    roommates = request.form['roomy']
    move = request.form['movein']

    # Check if user previously stated interest for a specific unit
    cursor = conn.cursor()
    query = 'SELECT * FROM Interests WHERE username = %s AND UnitRentID = %s'
    cursor.execute(query, (user, unit))
    data = cursor.fetchone()

    if data:
        error = "You have already stated your interest for this unit"
        session['error'] = error
        cursor.close()
        return redirect(url_for('viewUnit'))
    else:
        ins = 'INSERT INTO Interests VALUES(%s, %s, %s, %s)'
        cursor.execute(ins, (user, unit, roommates, move))
        conn.commit()
        cursor.close()
        session['error'] = None
        return redirect(url_for('viewUnit'))

# Deletes interest posted by a user
@app.route('/deleteInterest', methods=['GET', 'POST'])
def deleteInterest():
    # Get data
    username = session['username']
    unit = request.form['unit1']
    # Delete the specific entry
    cursor = conn.cursor()
    query = 'DELETE FROM Interests WHERE username = %s AND UnitRentID = %s'
    cursor.execute(query, (username, unit))
    conn.commit()
    cursor.close()
    session['error'] = None
    return redirect(url_for('viewUnit'))

# Shows the user's pets
@app.route('/pets',methods=['GET', 'POST'])
def pets():
    # Get data
    user = session['username']
    # Retrieve all the user's pets
    cursor = conn.cursor()
    query = 'SELECT PetName, PetType, PetSize FROM Pets WHERE username = %s '
    cursor.execute(query, (user))
    data = cursor.fetchall()
    cursor.close()
    error = session['error']
    return render_template('pets.html', username=user, posts=data, error=error)

# Adds a user's pet to the DB
@app.route('/addPet', methods=['GET', 'POST'])
def addPet():
    # Get data
    user = session['username']
    petName = request.form['petName']
    petType = request.form['petType']
    petSize = request.form['petSize']

    # Check for pre-existing pet with matching credentials
    cursor = conn.cursor()
    query = 'SELECT * FROM Pets WHERE username = %s AND PetName = %s AND PetType =%s'
    cursor.execute(query, (user,petName,petType))
    data = cursor.fetchone()

    if data:
        session['error'] = "A pet with this name and type already exists"
        cursor.close()
        return redirect(url_for('pets'))
    else:
        ins = 'INSERT INTO Pets VALUES(%s, %s, %s, %s)'
        cursor.execute(ins, (petName,petType,petSize,user))
        conn.commit()
        cursor.close()
        session['error'] = None
        return redirect(url_for('pets'))

# The page for editing an individual pet
@app.route('/editPet', methods=['GET', 'POST'])
def editPet():
    # Get data
    user = session['username']
    # First time approaching
    try:
        petName = request.form['petName']
        petType = request.form['petType']
        session['petName'] = petName
        session['petType'] = petType
        session['error'] = None
        error = None
    # Returning from an error
    except:
        petName = session['petName']
        petType = session['petType']
        error = session['error']

    # Gets the specific pet for editing
    cursor = conn.cursor()
    query = 'SELECT * FROM Pets WHERE username = %s AND PetName = %s AND PetType =%s'
    cursor.execute(query, (user,petName,petType))
    data = cursor.fetchone()
    cursor.close()
    return render_template('editpet.html', username=user, pet=data, error=error)

# Changes the details of the pet
@app.route('/changePet', methods=['GET', 'POST'])
def changePet():
    # Get data
    user = session['username']
    newPetName = request.form['newPetName']
    newPetType = request.form['newPetType']
    newPetSize = request.form['newPetSize']
    oldPetName = request.form['oldPetName']
    oldPetType = request.form['oldPetType']
    oldPetSize = request.form['oldPetSize']

    # cursor used to send queries
    cursor = conn.cursor()

    # If pet name and type haven't changed
    if (newPetName == oldPetName and newPetType == oldPetType):
        # If no change in size
        if(newPetSize == oldPetSize):
            session['error'] = "No values were changed"
            cursor.close()
            return redirect(url_for('editPet'))
        # Change pet's size
        else:
            ins = 'UPDATE Pets SET PetSize = %s WHERE PetName = %s AND PetType = %s AND username = %s'
            cursor.execute(ins, (newPetSize, oldPetName, oldPetType, user))
            conn.commit()
            cursor.close()
            session['error'] = None
            return redirect(url_for('pets'))

    # If pet name or type are different
    else:
        # Check for pre-existing pet with same name and type
        query = 'SELECT * FROM Pets WHERE username = %s AND PetName = %s AND PetType =%s'
        cursor.execute(query, (user,newPetName,newPetType))
        data = cursor.fetchone()
        if data:
            session['error'] = "A pet with this name and type already exists"
            cursor.close()
            return redirect(url_for('editPet'))
        else:
            ins = 'UPDATE Pets SET PetName = %s, PetType = %s, PetSize = %s WHERE PetName = %s AND PetType = %s AND username = %s'
            cursor.execute(ins, (newPetName,newPetType,newPetSize,oldPetName,oldPetType,user))
            conn.commit()
            cursor.close()
            session['error'] = None
            return redirect(url_for('pets'))

# Deletes a user's pet
@app.route('/deletePet', methods=['GET', 'POST'])
def deletePet():
    # Get data
    username = session['username']
    petName = request.form['petName']
    petType = request.form['petType']

    # Delete pet from user
    cursor = conn.cursor()
    query = 'DELETE FROM Pets WHERE username = %s AND PetName = %s AND PetType = %s'
    cursor.execute(query, (username, petName, petType))
    conn.commit()
    cursor.close()
    session['error'] = None
    return redirect(url_for('pets'))
@app.route('/logout')
def logout():
    session.pop('username')
    session.pop('error')
    session.pop('petName')
    session.pop('petType')
    session.pop('build')
    session.pop('comp')
    session.pop('unitID')
    return redirect('/')

# Run the app on localhost port 5000
# debug = True -> you don't have to restart flask
# for changes to go through, TURN OFF FOR PRODUCTION
if __name__ == "__main__":
    app.run('127.0.0.1', 5000, debug=True)
