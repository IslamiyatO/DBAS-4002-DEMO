-- Move to default database
Use master;
GO
-- create new database
DROP DATABASE IF EXISTS StudentDemo;
CREATE DATABASE StudentDemo;
GO
-- switch to new database
USE StudentDemo;
GO
-- Create Student table
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    StudentID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(32) NOT NULL,
    LastName NVARCHAR(32) NOT NULL,
    Age INT NOT NULL,
    Photo VARBINARY(MAX) NULL
);
GO
INSERT INTO Student (FirstName, LastName, Age, Photo)
VALUES ('John', 'Smith', 32, NULL);
GO
SELECT * FROM Student;
GO
-- Adding a foreign key
DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
    CourseID INT IDENTITY PRIMARY KEY,
    Code NCHAR(8) NOT NULL DEFAULT ('ABCD1234'),
    Name NVARCHAR(32) NOT NULL,
    StudentID INT NOT NULL
);
GO
ALTER TABLE Course
ADD CONSTRAINT FK__Student__StudentID
FOREIGN KEY (StudentID)
REFERENCES Student (StudentID) ON DELETE CASCADE ON UPDATE CASCADE;     -- ONLY USED WHEN THERE IS A NEED. YOU CAN ALSO SET IT TO NULL(SET NULL)
GO
INSERT INTO Course (Code, Name, StudentID)
VALUES ('DBAS4002', 'Transactional SQL Programming', 1);
GO
INSERT INTO Course (Name, StudentID)
VALUES  ('Default Name',1);
GO
-- Does not allow for duplicate code keys in the code
ALTER TABLE Course
ADD CONSTRAINT AK__Course__Code
UNIQUE (Code);
GO
-- To test UNIQUE constraint on Code
-- INSERT INTO Course (Code, Name, StudentID)
-- VALUES ('DBAS4002', 'Transactional SQL Programming', 1);
-- GO
-- To put age constraint on alter table: ie restrict age less than 0
ALTER TABLE Student
ADD CONSTRAINT CK__Student__Age
CHECK (Age > 0);
GO
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('John', 'Smith', 0, NULL);
-- GO
--  to default the firstname of the student to a blank; thus allowing empty value
ALTER TABLE Student
ADD CONSTRAINT DF__Student__FirstName
DEFAULT ('') FOR FirstName;
GO
INSERT INTO Student(LastName, Age, Photo)
VALUES ('Smith', 10, NULL);
GO
ALTER TABLE Student
ADD CONSTRAINT CK__Student__FirstName
CHECK (FirstName LIKE '%[^0-9]%');
GO
-- TO CHECK THAT THERE IS NO NUMBER ON THE PERSON'S LASTNAME 1.e any character
-- within the wildcard, icant have 0-9
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('Bob123', 'Jones', 45, NULL);
-- GO
ALTER TABLE Student
ADD CONSTRAINT CK__Student__LastName
CHECK (LEN(LastName) > 0 AND LastName NOT LIKE '%[0-9]%');
GO
-- TEST THAT LASTNAME MUST CONTAIN VALUES
-- INSERT INTO Student(FirstName, LastName, Age, Photo)
-- VALUES ('Mike', '', 34, NULL);
-- GO

ALTER TABLE Student
ADD CONSTRAINT CK__Student__LastName
CHECK (LEN(LastName)>0);
GO
-- To add a check constraint on the last name to make sure it's not blank
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('Mike', '', 34, NULL);
-- GO
INSERT INTO Student (FirstName, LastName, Age, Photo)
VALUES ('Mike', 'Jones', 34, NULL);
GO
-- To add a new field to the table Course
ALTER TABLE Course
ADD EnrolDate DATE NOT NULL DEFAULT (GETDATE());
GO
INSERT INTO Course (Code, Name, StudentID)
VALUES ('prog1400', 'Intro To OOP', 1);
GO





