-- Please use MYSQL to run the script

DROP DATABASE IF EXISTS `classdb`;

CREATE DATABASE `classdb` COLLATE `utf8_bin`;

USE `classdb`;

CREATE TABLE `classdb`.`Place` ( 
	`PlaceID` INT NOT NULL AUTO_INCREMENT , 
	`Latitude` DOUBLE NOT NULL , 
	`Longitude` DOUBLE NOT NULL , 
	`Elevation` INT NOT NULL , 
	`Population` BIGINT NOT NULL , 
	`Type` VARCHAR(100) NOT NULL , 
	`Country` VARCHAR(50) NOT NULL , 
	PRIMARY KEY (`PlaceID`)
	) ENGINE = InnoDB;
	
CREATE INDEX LatitudeIndex ON classdb.Place (`Latitude`) USING BTREE;
CREATE INDEX LongitudeIndex ON classdb.Place (`Longitude`) USING BTREE;

INSERT INTO Place (Latitude,Longitude,Elevation,Population,Type,Country) 
	VALUES (10.9876,65.8772,1000,987000,'Historic','Colombia');
INSERT INTO Place (Latitude,Longitude,Elevation,Population,Type,Country) 
	VALUES (98.10,15.11,2300,1000000,'Human Heritage','USA');
	
CREATE TABLE `classdb`.`Supplier` ( 
	`SupplierID` INT NOT NULL AUTO_INCREMENT , 
	`Name` VARCHAR(200) NOT NULL , 
	`Country` VARCHAR(100) NOT NULL , 
	`ReliabilityScore` INT NOT NULL , 
	`ContactInfo` INT NOT NULL , 
	PRIMARY KEY (`SupplierID`) 
	) ENGINE = InnoDB;

CREATE INDEX NameIndex ON classdb.Supplier (`Name`) USING BTREE;

INSERT INTO Supplier (Name,Country,ReliabilityScore,ContactInfo) 
	VALUES ('ABC Company','Chile',50,4084551088);
INSERT INTO Supplier(Name,Country,ReliabilityScore,ContactInfo) 
	VALUES ('Giving INC','USA',80,4081000098);
	
CREATE TABLE `classdb`.`SuppliedName` (
	`SnID` INT NOT NULL AUTO_INCREMENT ,
	`Name` VARCHAR(500) NOT NULL , 
	`Language` VARCHAR(150) NOT NULL ,
	`Status` VARCHAR(150) NOT NULL , 
	`Standard` VARCHAR(150) NOT NULL ,
	`PlaceID` INT NOT NULL ,
	`SupplierID` INT NOT NULL , 
	`DateSupplied` DATE NOT NULL ,
	PRIMARY KEY (`SnID`),
	FOREIGN KEY (`PlaceID`) REFERENCES Place(PlaceID),
	FOREIGN KEY (`SupplierID`) REFERENCES Supplier(SupplierID)
	) ENGINE = InnoDB;

INSERT INTO SuppliedName (Name,Language,Status,Standard,PlaceID,SupplierID,DateSupplied) 
	VALUES ('San Jose','Spanish','Obsolete','City',1,1,'2017-07-16');
INSERT INTO SuppliedName (Name,Language,Status,Standard,PlaceID,SupplierID,DateSupplied) 
	VALUES ('New York','English','Historical','City',2,2,'2017-07-15');

	
CREATE TABLE `classdb`.`Payment` (
	`SupplierID` INT NOT NULL , 
	`Date` DATE NOT NULL , 
	`Amount` INT NOT NULL,
	FOREIGN KEY (`SupplierID`) REFERENCES SuppliedName(SupplierID)
	) ENGINE = InnoDB;

INSERT INTO Payment (SupplierID,Date,Amount) 
	VALUES (1,'2017-07-16',1500);

INSERT INTO Payment (SupplierID,Date,Amount) 
	VALUES (2,'2017-07-16',2500);

	
CREATE TABLE `classdb`.`Department` ( 
	`DeptID` INT NOT NULL AUTO_INCREMENT, 
	`DeptName` VARCHAR(100) NOT NULL , 
	`DeptHeadID` INT NOT NULL , 
	`DeptHeadUserID` VARCHAR(100) NOT NULL , 
	`DeptAA` INT NOT NULL , 
	`ParentDeptID` INT NOT NULL,
	PRIMARY KEY (`DeptID`)) ENGINE = InnoDB;

INSERT INTO Department (DeptName,DeptHeadID,DeptHeadUserID,DeptAA,ParentDeptID) 
	VALUES ('IT',1,'ITUSER',1,0);
INSERT INTO Department (DeptName,DeptHeadID,DeptHeadUserID,DeptAA,ParentDeptID) 
	VALUES ('COMERCIAL',2,'COMUSER',2,1);


CREATE TABLE `classdb`.`Employee` ( 
	`EmpID` INT NOT NULL AUTO_INCREMENT , 
	`Name` VARCHAR(300) NOT NULL , 
	`TaxID` INT NOT NULL , 
	`Country` VARCHAR(100) NOT NULL , 
	`HireDate` DATE NOT NULL , 
	`BirthDate` DATE NOT NULL , 
	`Salary` INT NOT NULL , 
	`Bonus` INT NOT NULL , 
	`DeptID` INT NOT NULL , 
	PRIMARY KEY (`EmpID`),
	FOREIGN KEY (`DeptID`) REFERENCES Department(DeptID)
	) ENGINE = InnoDB;

INSERT INTO Employee (Name,TaxID,Country,HireDate,BirthDate,Salary,Bonus,DeptID) 
	VALUES ('Harrison',1234,'USA','2015-01-16','1987-03-16',10000,20000,1);
INSERT INTO Employee (Name,TaxID,Country,HireDate,BirthDate,Salary,Bonus,DeptID) 
	VALUES ('Christian',6666,'COL','2010-01-01','1960-01-16',20000,10000,2);
