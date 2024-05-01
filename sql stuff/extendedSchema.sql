-- Table creation
CREATE TABLE Favorites (
	username VARCHAR(20) NOT NULL,
	UnitRentID INT NOT NULL,
	FOREIGN KEY (username) REFERENCES Users (username),
	FOREIGN KEY (UnitRentID) REFERENCES ApartmentUnit (UnitRentID),
	PRIMARY KEY (username,UnitRentID)
);

CREATE TABLE Comments (
	username VARCHAR(20) NOT NULL,
	UnitRentID INT NOT NULL,
	cdate TIMESTAMP NOT NULL,
	details VARCHAR(300) NOT NULL,
	rating INT NOT NULL,
	FOREIGN KEY (username) REFERENCES Users (username),
	FOREIGN KEY (UnitRentID) REFERENCES ApartmentUnit (UnitRentID),
	PRIMARY KEY (username,UnitRentID,date)
);

-- Sample data insertion for Comments table
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("aj25082", 1, '2024-04-30 14:23:45', 'Great location, but noisy neighbors.', 4);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("jm19012", 2, '2024-04-30 09:15:00', 'Lovely view and well-maintained.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("ns37480", 2, '2024-04-30 20:10:30', 'Needs more parking space.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("cm68244", 3, '2024-04-30 18:00:00', 'Perfect for families.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("jh9679", 2, '2024-04-30 13:45:23', 'Maintenance is slow to respond.', 1);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("cn95660", 4, '2024-04-30 08:30:55', 'Super cozy and quiet.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("wm5558", 8, '2024-04-30 11:45:33', 'Affordable but small rooms.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("cm91354", 11, '2024-04-30 07:20:10', 'Very central and convenient location.', 4);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("md22185", 33, '2024-04-30 22:55:44', 'Older units but well priced.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("lc2652", 25, '2024-04-30 12:35:58', 'Great amenities and friendly staff.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("pj37052", 15, '2024-04-30 16:45:07', 'Could use an update on appliances.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("gc95084", 3, '2024-04-30 10:25:31', 'Spacious and well-lit rooms.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("jm86443", 54, '2024-04-30 21:40:22', 'Noisy at night due to traffic.', 2);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("rj70996", 29, '2024-04-30 17:05:49', 'Excellent gym facilities.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("mw20220", 37, '2024-04-30 19:30:00', 'Lacking in guest parking.', 2);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("lh3388", 91, '2024-04-30 15:20:20', 'Beautiful garden and pool area.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("dw00259", 12, '2024-04-30 23:55:55', 'Reasonably priced for the amenities.', 4);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("sj3988", 81, '2024-04-30 06:00:00', 'A bit outdated but clean.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("ba64590", 48, '2024-04-30 22:10:10', 'Friendly neighbors and safe area.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("bw7804", 34, '2024-04-30 05:45:45', 'Too expensive for the size.', 1);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("hj2345", 62, '2024-04-30 12:00:00', 'Modern design and eco-friendly.', 5);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("pj37052", 7, '2024-04-30 16:45:07', 'Could use an update on appliances.', 3);
INSERT INTO Comments (username, UnitRentID, cdate, details, rating) VALUES ("gc95084", 7, '2024-04-30 10:25:31', 'Spacious and well-lit rooms.', 5);

-- Sample data insertion for Favorites table
INSERT INTO Favorites (username, UnitRentID) VALUES ("aj25082", 1);
INSERT INTO Favorites (username, UnitRentID) VALUES ("aj25082", 11);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jm19012", 2);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jm19012", 32);
INSERT INTO Favorites (username, UnitRentID) VALUES ("ns37480", 24);
INSERT INTO Favorites (username, UnitRentID) VALUES ("ns37480", 2);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cm68244", 3);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cm68244", 33);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jh9679", 2);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jh9679", 22);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cn95660", 4);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cn95660", 44);
INSERT INTO Favorites (username, UnitRentID) VALUES ("wm5558", 8);
INSERT INTO Favorites (username, UnitRentID) VALUES ("wm5558", 89);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cm91354", 11);
INSERT INTO Favorites (username, UnitRentID) VALUES ("cm91354", 10);
INSERT INTO Favorites (username, UnitRentID) VALUES ("md22185", 33);
INSERT INTO Favorites (username, UnitRentID) VALUES ("md22185", 93);
INSERT INTO Favorites (username, UnitRentID) VALUES ("lc2652", 25);
INSERT INTO Favorites (username, UnitRentID) VALUES ("lc2652", 52);
INSERT INTO Favorites (username, UnitRentID) VALUES ("pj37052", 15);
INSERT INTO Favorites (username, UnitRentID) VALUES ("pj37052", 14);
INSERT INTO Favorites (username, UnitRentID) VALUES ("gc95084", 3);
INSERT INTO Favorites (username, UnitRentID) VALUES ("gc95084", 32);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jm86443", 54);
INSERT INTO Favorites (username, UnitRentID) VALUES ("jm86443", 45);
INSERT INTO Favorites (username, UnitRentID) VALUES ("rj70996", 29);
INSERT INTO Favorites (username, UnitRentID) VALUES ("rj70996", 2);
INSERT INTO Favorites (username, UnitRentID) VALUES ("mw20220", 7);
INSERT INTO Favorites (username, UnitRentID) VALUES ("mw20220", 3);
INSERT INTO Favorites (username, UnitRentID) VALUES ("lh3388", 91);
INSERT INTO Favorites (username, UnitRentID) VALUES ("lh3388", 43);
INSERT INTO Favorites (username, UnitRentID) VALUES ("dw00259", 12);
INSERT INTO Favorites (username, UnitRentID) VALUES ("dw00259", 15);
INSERT INTO Favorites (username, UnitRentID) VALUES ("sj3988", 81);
INSERT INTO Favorites (username, UnitRentID) VALUES ("sj3988", 1);
INSERT INTO Favorites (username, UnitRentID) VALUES ("ba64590", 12);
INSERT INTO Favorites (username, UnitRentID) VALUES ("ba64590", 48);
INSERT INTO Favorites (username, UnitRentID) VALUES ("bw7804", 27);
INSERT INTO Favorites (username, UnitRentID) VALUES ("bw7804", 34);
INSERT INTO Favorites (username, UnitRentID) VALUES ("hj2345", 60);
INSERT INTO Favorites (username, UnitRentID) VALUES ("hj2345", 62);