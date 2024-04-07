-- Sample date for Ammenities
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Swimming Pool', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Fitness Center', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Secure Garage', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Laundry Facilities', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('In-unit Laundry', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Dishwasher', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Air Conditioner', '');
INSERT INTO `Amenities` (`aType`, `Description`) VALUES ('Fireplace', '');

-- Sample data for ApartmentBuilding
INSERT INTO `ApartmentBuilding` (`CompanyName`, `BuildingName`, `AddrNum`, `AddrStreet`, `AddrCity`, `AddrState`, `AddrZipCode`, `YearBuilt`) VALUES ('Armani', 'North', '512', 'North Drive', 'New York', 'NY', '11370', '2014');
INSERT INTO `ApartmentBuilding` (`CompanyName`, `BuildingName`, `AddrNum`, `AddrStreet`, `AddrCity`, `AddrState`, `AddrZipCode`, `YearBuilt`) VALUES ('Armani', 'South', '230', 'South Drive', 'New York', 'NY', '11370', '2014');
INSERT INTO `ApartmentBuilding` (`CompanyName`, `BuildingName`, `AddrNum`, `AddrStreet`, `AddrCity`, `AddrState`, `AddrZipCode`, `YearBuilt`) VALUES ('Deluxe', 'Vista', '789', 'Walloby Way', 'New York', 'NY', '11370', '2008');

-- Sample data for PetPolicy
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`, `RegistrationFee`, `MonthlyFee`) VALUES ('Armani', 'North', 'Cat', 'Medium', '1', '100', '50');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`) VALUES ('Armani', 'North', 'Rodent', 'Small', '0');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`, `RegistrationFee`, `MonthlyFee`) VALUES ('Armani', 'South', 'Rodent', 'Small', '1', '50', '30');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`, `RegistrationFee`, `MonthlyFee`) VALUES ('Armani', 'South', 'Cat', 'Medium', '1', '100', '50');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`, `RegistrationFee`, `MonthlyFee`) VALUES ('Armani', 'South', 'Dog', 'Large', '1', '100', '70');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`, `RegistrationFee`, `MonthlyFee`) VALUES ('Deluxe', 'Vista', 'Bird', 'Small', '1', '50', '20');
INSERT INTO `PetPolicy` (`CompanyName`, `BuildingName`, `PetType`, `PetSize`, `isAllowed`) VALUES ('Deluxe', 'Vista', 'Dog', 'Large', '0');

-- Sample data for Provides
INSERT INTO `Provides` (`aType`, `CompanyName`, `BuildingName`, `Fee`, `waitingList`) VALUES ('Swimming Pool', 'Armani', 'North', '40', '2');
INSERT INTO `Provides` (`aType`, `CompanyName`, `BuildingName`, `Fee`, `waitingList`) VALUES ('Fitness Center', 'Armani', 'North', '10', '0');
INSERT INTO `Provides` (`aType`, `CompanyName`, `BuildingName`, `Fee`, `waitingList`) VALUES ('Laundry Facilities', 'Armani', 'South', '10', '0');
INSERT INTO `Provides` (`aType`, `CompanyName`, `BuildingName`, `Fee`, `waitingList`) VALUES ('Secure Garage', 'Armani', 'South', '50', '10');
INSERT INTO `Provides` (`aType`, `CompanyName`, `BuildingName`, `Fee`, `waitingList`) VALUES ('Swimming Pool', 'Deluxe', 'Vista', '40', '0');

-- Sample data for ApartmentUnit
INSERT INTO `ApartmentUnit` (`UnitRentID`, `CompanyName`, `BuildingName`, `unitNumber`, `MonthlyRent`, `squareFootage`, `AvailableDateForMoveIn`) VALUES ('1', 'Armani', 'North', '23', '1000', '800', '2024-04-16');
INSERT INTO `ApartmentUnit` (`UnitRentID`, `CompanyName`, `BuildingName`, `unitNumber`, `MonthlyRent`, `squareFootage`, `AvailableDateForMoveIn`) VALUES ('2', 'Armani', 'North', '24', '1200', '900', '2024-04-16');
INSERT INTO `ApartmentUnit` (`UnitRentID`, `CompanyName`, `BuildingName`, `unitNumber`, `MonthlyRent`, `squareFootage`, `AvailableDateForMoveIn`) VALUES ('3', 'Armani', 'South', '45', '1000', '800', '2024-05-12');
INSERT INTO `ApartmentUnit` (`UnitRentID`, `CompanyName`, `BuildingName`, `unitNumber`, `MonthlyRent`, `squareFootage`, `AvailableDateForMoveIn`) VALUES ('4', 'Deluxe', 'Vista', '8', '2500', '1400', '2024-04-30');

-- Sample data for AmenitiesIn
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('In-unit Laundry', '1');
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('Dishwasher', '1');
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('Fireplace', '2');
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('In-unit Laundry', '4');
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('Dishwasher', '4');
INSERT INTO `AmenitiesIn` (`aType`, `UnitRentID`) VALUES ('Air Conditioner', '4');

-- Sample data for Rooms
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Bedroom 1', '200', '', '1');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Living Room', '600', '', '1');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Studio', '900', '', '2');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Studio', '800', '', '3');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Bedroom 1', '300', '', '4');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Bedroom 2', '300', '', '4');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Dining Room', '400', '', '4');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Living Room', '200', '', '4');
INSERT INTO `Rooms` (`name`, `squareFootage`, `description`, `UnitRentID`) VALUES ('Dressing Room', '200', '', '4');

-- Sample data for Users
INSERT INTO `Users` (`username`, `first_name`, `last_name`, `DOB`, `gender`, `email`, `Phone`, `passwd`) VALUES ('NoobMaster', 'Chad', 'Thunder', '1994-10-21', '1', '555-123-4567', 'Chad@example.com', 'scrypt:32768:8:1$kMeTIJ1mJ9bmhkWF$0f6d70249a0db2f9cab308910de2ea07990f0751baafc8fb71e5768b5ffeb23801e17aba22211a74a60b208f0b344e4119ff64bf5ac6a16bca27418541c846aa');
INSERT INTO `Users` (`username`, `first_name`, `last_name`, `DOB`, `gender`, `email`, `Phone`, `passwd`) VALUES ('Zoey101', 'Zoe', 'Ferguson', '1999-05-05', '2', '555-234-4789', 'zoezoe@example.com', 'scrypt:32768:8:1$RRkDgF4VvBVovK3p$7c33e9ef1111719e3f61010256d943aa731e9930bb02383dc907474551dcb62b51678ad9b5581a30b6b2ecd10c101d65bf9fa80c38076cca237336e186087ce0');
INSERT INTO `Users` (`username`, `first_name`, `last_name`, `DOB`, `gender`, `email`, `Phone`, `passwd`) VALUES ('cheeseMB', 'Milly', 'Brown', '2002-10-23', '0', '555-444-9999', 'mb2002@example.com', 'scrypt:32768:8:1$6rL569gmJmVF5JbL$b76c9d6c763a7f2e03994574da453c7e42484a027f744a18c9e31fd33a92a93043c947022bdc5272d6d604068c1a13ff93da5b21f04786ee3ee9018206648dca');

-- Sample data for Pets
INSERT INTO `Pets` (`PetName`, `PetType`, `PetSize`, `username`) VALUES ('Simon', 'Rodent', 'Small', 'cheeseMB');
INSERT INTO `Pets` (`PetName`, `PetType`, `PetSize`, `username`) VALUES ('Jackson', 'Cat', 'Medium', 'cheeseMB');
INSERT INTO `Pets` (`PetName`, `PetType`, `PetSize`, `username`) VALUES ('Thunder Jr', 'Dog', 'Large', 'NoobMaster');
INSERT INTO `Pets` (`PetName`, `PetType`, `PetSize`, `username`) VALUES ('Tina', 'Bird', 'Small', 'Zoey101');

--Sample data for Interest
INSERT INTO `Interests` (`username`, `UnitRentID`, `RoommateCnt`, `MoveInDate`) VALUES ('cheeseMB', '3', '1', '2024-05-12');
INSERT INTO `Interests` (`username`, `UnitRentID`, `RoommateCnt`, `MoveInDate`) VALUES ('Zoey101', '4', '2', '2024-05-01');
