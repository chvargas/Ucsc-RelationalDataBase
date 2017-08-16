/* QUERY REPORTS*/ 

-- 1. Find the elevation and population of a place.

SELECT * FROM `place` WHERE `Elevation` 
SELECT * FROM `place` WHERE `Elevation` > 1500
SELECT * FROM `place` WHERE `Population`

-- 2. Find a place by a partial name.

SELECT * FROM `suppliedname` WHERE `Name` LIKE '%San%';

-- 3. Find a place in a latitude/longitude box (within a range of latitudes/longitudes)

SELECT * FROM `place` WHERE `Latitude` = 98.1 AND `Longitude` = 15.11

-- 4. Find a place by any of its names, listing its type, latitude, longitude, country, population and elevation.

SELECT * FROM `place`

-- 5. List all the alternate names of a place, along with language, type of name, and standard.

SELECT `SnID`, `Name`, `Language`, `Status` FROM `suppliedname`

-- 6. Find the supplier who supplied a particular name, along with other information about the supplier.

SELECT suppliedname.Name, Supplier.Name, Supplier.ContactInfo, Supplier.SupplierID 
FROM suppliedname, Supplier 
WHERE suppliedname.Name = 'San Jose' 
AND suppliedname.SupplierID = supplier.SupplierID
   
-- 7. Find how many more names are in each language this month (you can assume none are deleted – ever!)

SELECT SuppliedName.Name, SuppliedName.Language, count(SuppliedName.Name) AS Names
  FROM SuppliedName
  WHERE MONTH(DateSupplied)=7 AND YEAR(DateSupplied)=2017
 GROUP BY SuppliedName.Language;

SELECT SuppliedName.Name, SuppliedName.Language, count(SuppliedName.Name) AS Names 
 FROM SuppliedName 
 WHERE MONTH(DateSupplied)=6 AND YEAR(DateSupplied)=2017 
 GROUP BY SuppliedName.Language

-- 8. Find how much was paid out to suppliers this month, total

SELECT SUM(Amount) AS TOTAL 
  FROM payment
 WHERE MONTH(Date)=7 AND YEAR(Date)=2017;

-- 9. Find how much was paid out to suppliers this month, by supplier.

SELECT SupplierID, SUM(Amount) AS TOTAL 
  FROM Payment
 WHERE MONTH(Date)=7 AND YEAR(Date)=2017
 GROUP BY SupplierID;
 
-- 10. Show all employee information in a particular department.

SELECT * FROM `employee` WHERE `DeptID`=1

SELECT * FROM `employee` WHERE `DeptID`=2

-- 11. Increase salary by 10% and set bonus to 0 for all employees in a particular department.

UPDATE Employee
SET salary = salary * 1.10
WHERE DeptID = 1;

UPDATE Employee
SET bonus = 0
WHERE DeptID = 2;

-- 13. Show all supplier information sorted by country, including number of names supplied in 
-- current month and potential suppliers.

SELECT * FROM `supplier` ORDER BY Country 

SELECT SupplierID, SUM(Amount) AS TOTAL 
  FROM Payment
 WHERE MONTH(Date)=7 AND YEAR(Date)=2017
 GROUP BY SupplierID;

-- 14. Describe how you implemented the access restrictions on the previous page.

• All employees can see place and name information

	GRANT select ON SuppliedName TO Allemployees; 

• Only HR employees can access all HR info.

	GRANT select ON Employee TO HREmployees; 
	GRANT select ON Department TO HREmployees; 
	
• Only some HR employees can change the information in the HR portion of the DB

	GRANT select, update ON Employee TO ‘HR Manager’;
	GRANT select, update ON Department TO ‘HR Manager’;

• Managers can see their employee information
	
	GRANT select ON Employee TO ManagersDepartments ONLY for his own department employees ; 

• Managers can update their employee compensation.

	GRANT select, update ON Employee.Salary TO ‘Managers’ ONLY for his own department employees ;;

-- 15. Describe how you implement the constraints shown in the ERD and on the employee info.

	-- The constraints were described by SQL commands that were written above. 
	-- I followed the ERD constraints rules that were given in ERD document, every table includes the constraints in the code. 
	-- I used the command FOREIGN KEY based on ERD in all relationships.