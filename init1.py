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
    # grabs information from the forms
    username = request.form['username']
    password = request.form['password']

    # cursor used to send queries
    cursor = conn.cursor()
    # executes query
    query = 'SELECT passwd FROM Users WHERE username = %s'
    cursor.execute(query, (username))
    # stores the results in a variable
    data = cursor.fetchone()
    cursor.close()
    error = None
    # Checks hashed password with one provided by login
    if data and check_password_hash(data["passwd"], password):
        # creates a session for the user
        # session is a built in
        session['username'] = username
        return redirect(url_for('home'))
    else:
        # returns an error message to the html page
        error = 'Invalid login or username'
        return render_template('login.html', error=error)

# Authenticates the register
@app.route('/registerAuth', methods=['GET', 'POST'])
def registerAuth():
    # grabs information from the forms
    username = request.form['username']
    passwd = request.form['password']
    first_name = request.form['firstname']
    last_name = request.form['lastname']
    DOB = request.form['birthday']
    gender = request.form['gender']
    Phone = request.form['phone']
    email = request.form['email']

    # cursor used to send queries
    cursor = conn.cursor()
    # executes query
    query = 'SELECT * FROM Users WHERE username = %s'
    cursor.execute(query, (username))
    # stores the results in a variable
    data = cursor.fetchone()
    error = None
    if data:
        # If the previous query returns data, then user exists
        error = "This user already exists"
        return render_template('register.html', error = error)
    else:
        # Hash password using werkzeug module
        passwd = generate_password_hash(passwd)
        ins = 'INSERT INTO Users VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (username, first_name, last_name, DOB, gender, Phone, email, passwd))
        conn.commit()
        cursor.close()
        return render_template('landing.html')

# Takes user to homepage upon login
@app.route('/home')
def home():
    user = session['username']
    return render_template('home.html', username=user)

@app.route('/logout')
def logout():
    session.pop('username')
    return redirect('/')
# Run the app on localhost port 5000
# debug = True -> you don't have to restart flask
# for changes to go through, TURN OFF FOR PRODUCTION
if __name__ == "__main__":
    app.run('127.0.0.1', 5000, debug=True)
