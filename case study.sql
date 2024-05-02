create database TransportSystem
CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    Model VARCHAR(25),
    Capacity DECIMAL(10, 2),
    [Type] VARCHAR(50),
    [Status] VARCHAR(50)
)
ALTER TABLE Vehicles
ADD CONSTRAINT check_vehicle CHECK(Status IN( 'Available', 'On Trip', 'Maintenance'))

CREATE TABLE Routes (
    RouteID INT IDENTITY(100,1) PRIMARY KEY,
    StartDestination VARCHAR(255),
    EndDestination VARCHAR(255),
    Distance DECIMAL(10, 2)
)

CREATE TABLE Trips (
    TripID INT IDENTITY(200,1) PRIMARY KEY,
    VehicleID INT,
    RouteID INT,
    DepartureDate DATETIME,
    ArrivalDate DATETIME,
    [Status] VARCHAR(50),
    TripType VARCHAR(50) DEFAULT 'Freight',
    MaxPassengers INT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) on delete cascade,
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID) on delete cascade
)
ALTER TABLE Trips
ADD CONSTRAINT check_trip CHECK(Status IN('Scheduled', 'In Progress', 'Cancelled', 'Completed'))

CREATE TABLE Passengers (
    PassengerID INT IDENTITY(300,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    Gender VARCHAR(50),
    Age INT,
    Email VARCHAR(50) UNIQUE,
    PhoneNumber VARCHAR(50)
)

CREATE TABLE Bookings (
    BookingID INT IDENTITY(400,1) PRIMARY KEY,
    TripID INT,
    PassengerID INT,
    BookingDate DATETIME,
    Status VARCHAR(50),
    FOREIGN KEY (TripID) REFERENCES Trips(TripID) on delete cascade,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID) on delete cascade
)
ALTER TABLE Bookings
ADD CONSTRAINT check_status CHECK(Status IN('Confirmed', 'Cancelled', 'Completed'))

INSERT INTO Vehicles VALUES
('BMW X5', 5.0, 'SUV', 'Available'),
('Toyota Prius', 43.0, 'Hybrid', 'On Trip'),
('Ford Transit', 15.0, 'Van', 'Maintenance'),
('Volkswagen Golf', 55.0, 'Hatchback', 'Available');
 select * from Vehicles

INSERT INTO Routes (StartDestination, EndDestination, Distance) VALUES
('Madurai', 'Tirunelveli', 270.5),
('Kadaloor', 'Vayanaad', 286.2),
('Tanjore', 'Chennai', 397.8),
('Avadi', 'Chengalpattu', 130.9);
 select * from Routes

INSERT INTO Trips (VehicleID, RouteID, DepartureDate, ArrivalDate, [Status], TripType, MaxPassengers) VALUES
(1, 100, '2024-04-19 08:00:00', '2024-04-23 15:00:00', 'In Progress', 'Passenger', 5),
(2, 101, '2024-04-24 10:00:00', '2024-04-29 14:30:00', 'Scheduled', 'Freight', 8),
(3, 102, '2024-04-26 12:00:00', '2024-04-30 19:30:00', 'Completed', 'Passenger', 6),
(4, 103, '2024-05-01 09:30:00', '2024-05-06 12:45:00', 'Cancelled', 'Freight', 0);
 select * from Trips

INSERT INTO Passengers VALUES ('Saiprasath', 'Male', 20, 'sai@yahoo.com', '787986000'),
('Harsh', 'Male',36, 'harsh@gmail.com', '9968965640'),
('Roni', 'Female', 24, 'roni@yahoo.com', '6977634599'),
('Vinith', 'male', 29, 'vinith@gmail.com', '8778470663')
 select * from Passengers

INSERT INTO Bookings VALUES (208, 300, '2024-04-12 09:00:00', 'Confirmed'),
(209, 301, '2023-04-15 10:00:00', 'Completed'),
(210, 302, '2023-03-21 18:30:00', 'Completed'),
(211, 303,'2024-04-29 09:45:00', 'Cancelled');
 select * from Bookings
