USE StudentDemo;
GO
-- simple INSERT Statement
INSERT INTO dbo.Student (FirstName, LastName, Age, Photo)
VALUES ('John', 'Smith', 45, NULL),
       ('Jane', 'Doe', 32, NULL),
       ('Jack', 'Sprat', 19, NULL);

--To print out the StudentID number
PRINT '@@IDENTITY: ' + STR(@@IDENTITY);
-- To assign a course to Jack Sprat
INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4004', 'Transactional SQL', @@IDENTITY, GETDATE());

PRINT 'SCOPE_IDENTITY(): ' + STR(SCOPE_IDENTITY());

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4004', 'Transactional SQL', SCOPE_IDENTITY(), GETDATE());

--MAKE A NEW insert statement into student-- tO RETRIEVE AN IDENTITY FIELD FOR A LATER USE
INSERT INTO dbo.Student (FirstName, LastName, Age, Photo)
VALUES ('Tom', 'Thumb', 36, NULL);

DECLARE @StudentID INT;
SET @StudentID = SCOPE_IDENTITY();

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4005', 'Transactional SQL', @StudentID, GETDATE()),
       ('PROG1401', 'Intro to OOP', @StudentID, GETDATE());

--TO INSERT MANUALLY. YOU TURN ON THE IDENTITY FIELD\
SET IDENTITY_INSERT Student ON;
INSERT INTO Student (StudentID,FirstName, LastName, Age, Photo)
VALUES ('100', 'Nancy', 'Drew', 41, NULL);
SET IDENTITY_INSERT Student OFF;

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4006', 'Transactional SQL', 100, GETDATE()),
       ('PROG1402', 'Intro to OOP', 100, GETDATE());
--To delete a record
DELETE FROM Course
WHERE CourseID = 11;

--tO DELETE JACK SPRAT WITH COURSE 100 this is done manually as you
-- as you have to delete the course 1st before the child record
DELETE FROM dbo.Student
WHERE StudentID = 100;
--To update the course from into to 00p to Object oriented
UPDATE Course
SET Name = 'Into to Object-Oriented'
WHERE CourseID = 10;
--To change multiple fields
UPDATE Course
SET CourseID = 7
WHERE CourseID =10;
--Since it cant upDATE THE record with the above codes, then you use the line f codes below.
SET IDENTITY_INSERT Course ON;
DECLARE @Name VARCHAR(32);
DECLARE @Code NCHAR(25);
DECLARE @StudentID INT;
DECLARE @EnrolDate DATETIME;
SELECT @Code = Code, @Name = Name, @StudentID = StudentID, @EnrolDate = EnrolDate
FROM Course;
INSERT INTO Course (CourseID, Code, Name, StudentID, EnrolDate)
VALUES  (5, @Code + '_New', @Name, @StudentID, @EnrolDate )
DELETE FROM Course
WHERE CourseID = 10;
SET IDENTITY_INSERT Course OFF;

-- SELECT Statements
USE AdventureWorks2017;
GO
SELECT * FROM Person.Person
WHERE FirstName LIKE "%Ken%";
GO
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
INNER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
RIGHT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
-- tO DO THE FULL JOIN ,use union to join the left and right outer join
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
UNION ALL
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
RIGHT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
--THE FULL OUTER JOIN shows the duplicate
SELECT FirstName, LastName,JobTitle
FROM Person.Person p
FULL OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
-- To get rid of the duplicates use DISTINCT
SELECT DISTINCT FirstName, LastName, JobTitle
FROM Person.Person p
FULL OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO

--The group by condenses all the duplicates and count all the  duplicate records
SELECT FirstName, LastName, JobTitle, COUNT(*) AS DuplicateCount
FROM Person.Person p
FULL OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
GROUP BY FirstName, LastName, JobTitle
-- the having clause is used to filter out based on duplicate. Count counts all the records
HAVING COUNT(*) > 1
ORDER BY LastName;
-- the Spring agg function
SELECT STRING_AGG(CONVERT(NVARCHAR(MAX), FirstName), ',') AS csv
FROM Person.Person;

SELECT FirstName,LastName FROM Person.Person;
GO

-- TO PUT FNAME AND LNAME IN A SINGLE FIELD CALLED CONCATENATING STRINGS
SELECT FirstName + ' ', LastName AS FullName FROM Person.Person;
SELECT CONCAT(FirstName + ' ', LastName) AS FullName FROM Person.Person;
--SUBSTRING( expression, start, length). 2 means start at 2nd index then 3 means ,print 3 letters e.g SYED = YED
SELECT FirstName, SUBSTRING(FirstName , 2,3) FROM Person.Person;

--to kno the pEXACT SPOT of the character CHARINDEX (expressionToFind,  expresionToSearch
-- E.G the spot for 'a' in  catherine is 2
SELECT FirstName, CHARINDEX('a' , FirstName) FROM Person.Person;

--TO DO LEFT SIDE
SELECT LEFT(FirstName, 1) AS Initial FROM Person.Person;
SELECT CONCAT(LEFT(FirstName, 1),LEFT(LastName, 3)) AS Username FROM Person.Person;

-- TO CHANGE TO LOWER CASE or UPPER CASE
SELECT LOWER (CONCAT(LEFT(FirstName, 1),LEFT(LastName, 3))) AS Username FROM Person.Person;
--upper
SELECT UPPER (CONCAT(LEFT(FirstName, 1),LEFT(LastName, 3))) AS Username FROM Person.Person;

--LTRIM(TRIMS TO THE LEFT), RTRIM(trims to the right), TRIM(trims on both sides) characters, THIS GETS RID OF EXTRINEOUS SPACINGS
--TO PRINT INFO FROM SAlES ORDER TABLE
SELECT Subtotal TaxAmt TotalDue
FROM Sales.SalesOrderHeader;

-- to concatenate with + and = sign in between them
SELECT STR(Subtotal) + ' + ' + STR(TaxAmt) + ' =' + STR(TotalDue)
FROM Sales.SalesOrderHeader;

-- THE NUMBER CAN HELP IN DISPLAYING THINGS AND INCLUDE DP
-- YOU CAN CHANGE THE LENGTH DEPENDING ON THE SPACE, THE 2 IS THE DP
SELECT STR(Subtotal,10, 2) + ' + ' + STR(TaxAmt, 10, 2) + ' =' + STR(TotalDue,10, 2)
FROM Sales.SalesOrderHeader;

-- To trim using LTRIM
SELECT LTRIM(STR(Subtotal,10, 2)) + ' + ' +
       LTRIM(STR(TaxAmt, 10, 2)) + ' =' +
       LTRIM(STR(TotalDue,10, 2))
FROM Sales.SalesOrderHeader;

-- lEN (string_expression) determines the length of the string
SELECT (FirstName + ' ' + LastName) AS FullName,
      LEN(FirstName + ' ' + LastName) AS Length
FROM Person.Person;

-- to do the maximum
SELECT MAX(LEN(FirstName + ' ' + LastName)) AS Length
FROM Person.Person;

-- CAST( TO THE NEAREST WHOLE NUMBER)/CONVERT
SELECT TotalDue, CAST (TotalDue AS INT) FROM Sales.SalesOrderHeader;
SELECT TotalDue, CONVERT (INT, TotalDue) FROM Sales.SalesOrderHeader;

--Datetime(to diplay the current date you cab add 7 to the convert statement, the ISO format
-- of the date is 127 0r 126
SELECT  OrderDate FROM Sales.SalesOrderHeader;
 -- TO CHANGE THE FORMAT OF THE DAATE, YOU CAN USE THE CONVERT FUNCTION
 SELECT  OrderDate, CONVERT(VARCHAR, OrderDate, 7) FROM Sales.SalesOrderHeader;
 SELECT  OrderDate, CONVERT(VARCHAR, OrderDate, 127) FROM Sales.SalesOrderHeader;

--Date / time Functions
-- Day/ Month/year- to extract date elememts
-- to pull out the years
SELECT OrderDate, YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 12;

-- DATEPART (datepart, date)
-- To extract the hour, minutes or seconds
SELECT OrderDate, DATEPART(HOUR, OrderDate), DATEPART(MINUTE ,OrderDate)
FROM Sales.SalesOrderHeader;