-- Create tables
CREATE TABLE `flight`(
    `flight_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pilot` INT UNSIGNED NOT NULL,
    `passenger` INT UNSIGNED NULL,
    `aircraft` INT UNSIGNED NOT NULL,
    `bill_to` INT UNSIGNED NULL,
    `launch_method` ENUM('aero', 'winch', 'car', 'self') NOT NULL,
    `type` ENUM('member', 'premium', 'standard', 'neclub') NOT NULL,
    `tender` ENUM('cash', 'charge', 'check', 'nocharge') NOT NULL,
    `collected` DOUBLE(8, 2) NULL,
    `start` DATETIME NOT NULL,
    `end` DATETIME NOT NULL,
    `release` VARCHAR(20) NOT NULL,
    `note` VARCHAR(255) NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `club_aircraft`(
    `club_aircraft_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `club` INT UNSIGNED NOT NULL,
    `aircraft` INT UNSIGNED NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `person_role`(
    `person_role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `role` INT UNSIGNED NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `person`(
    `person_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `active` TINYINT(1) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NULL,
    `phone` VARCHAR(255) NULL,
    `alternate_phone` VARCHAR(255) NULL,
    `address` VARCHAR(255) NULL,
    `city` VARCHAR(255) NULL,
    `state` CHAR(2) NULL,
    `zip` CHAR(10) NULL,
    `ssa_identifier` VARCHAR(255) NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `person_operation`(
    `person_operation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `operation` INT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `credit_for` ENUM('ride_pilot', 'instructor', 'tow_pilot', 'duty_officer') NULL,
    `note` VARCHAR(255) NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `person_aircraft`(
    `person_aircraft_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `aircraft` INT UNSIGNED NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `role`(
    `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `private` TINYINT(1) NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `person_club`(
    `person_club_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `club` INT UNSIGNED NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `aircraft`(
    `aircraft_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `active` TINYINT(1) NOT NULL,
    `registration` VARCHAR(255) NOT NULL,
    `make` VARCHAR(255) NOT NULL,
    `model` VARCHAR(255) NOT NULL,
    `category` ENUM('glider', 'airplane') NOT NULL,
    `last_inspection` DATE NOT NULL,
    `registration_expires` DATE NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `member`(
    `member_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `active` TINYINT(1) NOT NULL,
    `started` DATETIME NOT NULL,
    `ended` DATETIME NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `certification`(
    `certification_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `person` INT UNSIGNED NOT NULL,
    `issuer` INT UNSIGNED NULL,
    `type` ENUM('medical', 'ground_operations', 'rating', 'endorsement') NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `issuer_organization` VARCHAR(255) NULL,
    `note` VARCHAR(255) NULL,
    `issued` DATETIME NOT NULL,
    `expires` DATETIME NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `operation`(
    `operation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `date` DATE NOT NULL,
    `note` VARCHAR(255) NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `bill`(
    `bill_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `flight` INT UNSIGNED NOT NULL,
    `status` ENUM('pending', 'sent', 'cancelled') NOT NULL DEFAULT 'pending',
    `sent` DATETIME NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `club`(
    `club_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `active` TINYINT(1) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `short_name` VARCHAR(10) NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Define table relationships
ALTER TABLE `person_aircraft`
ADD CONSTRAINT `person_aircraft_person_foreign`
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `flight` 
ADD CONSTRAINT `flight_passenger_foreign` 
FOREIGN KEY(`passenger`) REFERENCES `person`(`person_id`);

ALTER TABLE `member` 
ADD CONSTRAINT `member_person_foreign` 
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `club_aircraft` 
ADD CONSTRAINT `club_aircraft_club_foreign` 
FOREIGN KEY(`club`) REFERENCES `club`(`club_id`);

ALTER TABLE `flight` 
ADD CONSTRAINT `flight_bill_to_foreign` 
FOREIGN KEY(`bill_to`) REFERENCES `person`(`person_id`);

ALTER TABLE `bill` 
ADD CONSTRAINT `bill_flight_foreign` 
FOREIGN KEY(`flight`) REFERENCES `flight`(`flight_id`);

ALTER TABLE `person_operation` 
ADD CONSTRAINT `person_operation_person_foreign` 
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `person_role` 
ADD CONSTRAINT `person_role_role_foreign` 
FOREIGN KEY(`role`) REFERENCES `role`(`role_id`);

ALTER TABLE `certification` 
ADD CONSTRAINT `certification_person_foreign` 
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `club_aircraft` 
ADD CONSTRAINT `club_aircraft_aircraft_foreign` 
FOREIGN KEY(`aircraft`) REFERENCES `aircraft`(`aircraft_id`);

ALTER TABLE `person_club` 
ADD CONSTRAINT `person_club_person_foreign` 
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);

ALTER TABLE `certification` 
ADD CONSTRAINT `certification_issuer_foreign` 
FOREIGN KEY(`issuer`) REFERENCES `person`(`person_id`);

ALTER TABLE `flight` 
ADD CONSTRAINT `flight_pilot_foreign` 
FOREIGN KEY(`pilot`) REFERENCES `person`(`person_id`);

ALTER TABLE `person_club` 
ADD CONSTRAINT `person_club_club_foreign` 
FOREIGN KEY(`club`) REFERENCES `club`(`club_id`);

ALTER TABLE `person_aircraft` 
ADD CONSTRAINT `person_aircraft_aircraft_foreign` 
FOREIGN KEY(`aircraft`) REFERENCES `aircraft`(`aircraft_id`);

ALTER TABLE `person_operation` 
ADD CONSTRAINT `person_operation_operation_foreign` 
FOREIGN KEY(`operation`) REFERENCES `operation`(`operation_id`);

ALTER TABLE `person_role` 
ADD CONSTRAINT `person_role_person_foreign` 
FOREIGN KEY(`person`) REFERENCES `person`(`person_id`);
