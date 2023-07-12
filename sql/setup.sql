-- Use the 'fsa' database
USE fsa;

-- Create the 'Person' table
CREATE TABLE Person (
    PersonId INT PRIMARY KEY AUTO_INCREMENT,
    Member INT,
    Active BOOLEAN,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(255),
    AlternatePhone VARCHAR(255),
    Address VARCHAR(255),
    State VARCHAR(255),
    City VARCHAR(255),
    Zip INT,
    SSAIdentifier INT,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'Flights' table
CREATE TABLE Flight (
    FlightId INT PRIMARY KEY AUTO_INCREMENT,
    Pilot INT NOT NULL,
    Passenger INT,
    Aircraft INT NOT NULL,
    BillTo INT,
    LaunchMethod ENUM('aero', 'winch', 'car', 'self') NOT NULL,
    Type ENUM('member', 'premium', 'standard', 'neclub') NOT NULL,
    Tender ENUM('cash', 'charge', 'check', 'nocharge') NOT NULL,
    Collected FLOAT,
    Start TIMESTAMP NOT NULL,
    End TIMESTAMP NOT NULL,
    `Release` INT,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Memo VARCHAR(255)
);

-- Create the 'Aircraft' table
CREATE TABLE Aircraft (
    AircraftId INT PRIMARY KEY AUTO_INCREMENT,
    Active BOOLEAN,
    Registration VARCHAR(255) NOT NULL,
    Make VARCHAR(255) NOT NULL,
    Model VARCHAR(255) NOT NULL,
    Category ENUM('glider', 'airplane') NOT NULL,
    LastInspection TIMESTAMP,
    RegistrationExpires TIMESTAMP,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'Members' table
CREATE TABLE Member (
    MemberId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT NOT NULL,
    Active BOOLEAN,
    Started TIMESTAMP NOT NULL,
    Ended TIMESTAMP,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'Certifications' table
CREATE TABLE Certification (
    CertificationId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT NOT NULL,
    Issuer INT,
    Type ENUM('medical', 'ground_operations', 'rating', 'endorsement') NOT NULL,
    Name VARCHAR(255) NOT NULL,
    IssuerOrganization VARCHAR(255),
    Memo VARCHAR(255),
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Issued TIMESTAMP,
    Expires TIMESTAMP
);

-- Create the 'Clubs' table
CREATE TABLE Club (
    ClubId INT PRIMARY KEY AUTO_INCREMENT,
    Active BOOLEAN DEFAULT TRUE,
    Name VARCHAR(255) NOT NULL,
    ShortName VARCHAR(10) NOT NULL,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'Roles' table
CREATE TABLE Role (
    RoleId INT PRIMARY KEY AUTO_INCREMENT,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Private BOOLEAN
);

-- Create the 'Operations' table
CREATE TABLE Operation (
    OperationId INT PRIMARY KEY AUTO_INCREMENT,
    Date DATE,
    DutyOfficer INT,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Memo VARCHAR(255)
);

-- Create the 'Billing' table
CREATE TABLE Billing (
    BillId INT PRIMARY KEY AUTO_INCREMENT,
    Flight INT,
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('pending', 'sent', 'cancelled') DEFAULT 'pending',
    Sent TIMESTAMP
);

-- Create the 'PersonOperations' table
CREATE TABLE PersonOperation (
    OperationPilotsId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT,
    Date DATE,
    Type ENUM('ride', 'instructor', 'tow'),
    Memo VARCHAR(255)
);

-- Create the 'PersonClubs' table
CREATE TABLE PersonClub (
    PersonClubsId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT,
    Club INT
);

-- Create the 'PersonRoles' table
CREATE TABLE PersonRole (
    PersonRolesId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT,
    Role INT
);

-- Create the 'PersonAircraft' table
CREATE TABLE PersonAircraft (
    PersonAircraftId INT PRIMARY KEY AUTO_INCREMENT,
    Person INT,
    Aircraft INT
);

-- Create the 'ClubAircraft' table
CREATE TABLE ClubAircraft (
    ClubAircraftId INT PRIMARY KEY AUTO_INCREMENT,
    Club INT,
    Aircraft INT
);
