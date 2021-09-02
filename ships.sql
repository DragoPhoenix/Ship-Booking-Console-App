drop database ship_booking;

CREATE DATABASE ship_booking;

USE ship_booking;

CREATE TABLE adminTable (
adminID INT AUTO_INCREMENT,
password VARCHAR(30) NOT NULL,
email VARCHAR(30) NOT NULL UNIQUE,
PRIMARY KEY (adminID)
);

CREATE TABLE userTable (
userID INT AUTO_INCREMENT,
phoneNumber BIGINT(11),
name VARCHAR(30),
age INT,
gender ENUM('M' , 'F') ,
password VARCHAR(30) NOT NULL,
email VARCHAR(30) NOT NULL UNIQUE,
PRIMARY KEY (userID)
);

CREATE TABLE cruiseShipsTable (
cruiseShipID INT AUTO_INCREMENT,
fromLocation VARCHAR(30) NOT NULL,
toLocation VARCHAR(30) NOT NULL,
departureTime BIGINT NOT NULL,
arrivalTime BIGINT NOT NULL,
totalSeats INT NOT NULL,
cost INT NOT NULL,
bookedSeats INT DEFAULT '0',
PRIMARY KEY (cruiseShipID)
);

CREATE TABLE cargoShipsTable (
cargoShipID INT AUTO_INCREMENT,
fromLocation VARCHAR(30) NOT NULL,
toLocation VARCHAR(30) NOT NULL,
departureTime BIGINT NOT NULL,
arrivalTime BIGINT NOT NULL,
capacity INT NOT NULL,
chargesPerTonne INT NOT NULL,
bookedCapacity INT DEFAULT '0',
PRIMARY KEY (cargoShipID)
);

CREATE TABLE cruiseBookingTable (
cruiseBookingID INT AUTO_INCREMENT,
cruiseShipID INT,
userID INT, 
cost INT,
statusFlag INT NOT NULL,
PRIMARY KEY (cruiseBookingID),
CONSTRAINT fk1 foreign key(cruiseShipID) REFERENCES cruiseShipsTable(cruiseShipID),
CONSTRAINT fk2 foreign key(userID) REFERENCES userTable(userID)
);

CREATE TABLE cargoBookingTable (
cargoBookingID INT AUTO_INCREMENT,
cargoShipID INT,
userID INT,
cost INT,
statusFlag INT NOT NULL,
PRIMARY KEY (cargoBookingID),
CONSTRAINT fk3 foreign key(cargoShipID) REFERENCES cargoShipsTable(cargoShipID),
CONSTRAINT fk4 foreign key(userID) REFERENCES userTable(userID)
);

INSERT INTO adminTable(password,email) VALUES
("testAdmin1","admin1@38.com"),
("testAdmin2","admin2@38.com");

INSERT INTO userTable( phoneNumber , name , age , gender , password , email ) VALUES 
(1234567890 , "user1" , 33 , 'M' , "testUser1" , "user1@38.com"),
(1234567899 , "user2" , 32 , 'F' , "testUser2" , "user2@38.com");

INSERT INTO cargoShipsTable( fromLocation , toLocation , departureTime , arrivalTime , capacity , chargesPerTonne) VALUES 
("chicago" , "london" , 20 , 50 , 500 , 34 ) ,
("new york" , "amsterdam" , 25 , 50 , 800 , 40) ,
("singapore" , "sydney" , 133 , 500 , 433 , 34),
("tokyo" , "mumbai" , 1000 , 1060 , 433 , 34),
("tokyo" , "london" , 224 , 442 , 433 , 34),
("tokyo" , "mumbai" , 1 , 100 , 5000 , 100) ;


INSERT INTO cruiseShipsTable( fromLocation , toLocation , departureTime , arrivalTime , totalSeats , cost ) VALUES 
("chicago" , "london" , 42 , 234 , 4331 , 100 ) ,
("new york" , "amsterdam" , 442 , 423 , 3000 , 20 ) ,
("singapore" , "sydney" , 242 , 4 , 2000 , 800 ) ,
("tokyo" , "mumbai" , 204 , 400 , 50 , 4000 ),
("tokyo" , "london" , 209 , 423 , 2000 , 30 ),
("tokyo" , "mumbai" , 500 , 100 , 4332 , 5 );

CREATE VIEW cruiseBookingJoin AS SELECT totalSeats,departureTime,arrivalTime,cruiseBookingID,userID,cruiseBookingTable.cruiseShipID,bookedSeats,(cruiseBookingTable.cost)DIV(cruiseShipsTable.cost)AS seats,statusFlag,cruiseBookingTable.cost,fromLocation,toLocation FROM cruiseBookingTable INNER JOIN cruiseShipsTable ON cruiseBookingTable.cruiseShipID=cruiseShipsTable.cruiseShipID;
CREATE VIEW cargoBookingJoin AS SELECT statusFlag,capacity,departureTime,arrivalTime,cargoBookingID,userID,cargoBookingTable.cargoShipID,bookedCapacity,(cargoBookingTable.cost)DIV(cargoShipsTable.chargesPerTonne)AS capacityBooked FROM cargoBookingTable INNER JOIN cargoShipsTable ON cargoBookingTable.cargoShipID=cargoShipsTable.cargoShipID;


Delimiter #
CREATE TRIGGER update_bookedSeats1
AFTER INSERT 
ON cruiseBookingTable
FOR EACH ROW
IF(NEW.statusFlag='1') THEN
UPDATE cruiseShipsTable SET bookedSeats=((NEW.cost)/(cruiseShipsTable.cost))+bookedSeats WHERE cruiseShipsTable.cruiseShipID=NEW.cruiseShipID;
END IF #
Delimiter ;


Delimiter #
CREATE TRIGGER update_bookedSeats2
AFTER UPDATE 
ON cruiseBookingTable
FOR EACH ROW
IF(NEW.statusFlag='1') THEN
UPDATE cruiseShipsTable SET bookedSeats=((NEW.cost)/(cruiseShipsTable.cost))+bookedSeats WHERE cruiseShipsTable.cruiseShipID=NEW.cruiseShipID;
END IF #
Delimiter ;

-- CREATE TRIGGER update_bookedCapacity
-- AFTER INSERT
-- ON cargoBookingTable
-- FOR EACH ROW
-- UPDATE cargoShipsTable SET bookedCapacity=((NEW.cost)/(chargesPerTonne))+bookedCapacity WHERE cargoShipsTable.cargoShipID=NEW.cargoShipID;

Delimiter #
CREATE TRIGGER after_cancellation
AFTER UPDATE
ON cruiseBookingTable
FOR EACH ROW
IF (NEW.statusFlag='3' AND OLD.statusFlag='1') THEN
UPDATE cruiseBookingJoin SET bookedSeats=bookedSeats-seats WHERE cruiseBookingID=NEW.cruiseBookingID;
END IF #
Delimiter ;
