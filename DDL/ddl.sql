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
    Code NCHAR(8) NOT NULL,
    Name NVARCHAR(32) NOT NULL,
    StudentID INT NOT NULL
);
GO
ALTER TABLE Course
ADD CONSTRAINT FK__Student__StudentID
FOREIGN KEY (StudentID)
REFERENCES Student (StudentID) ON DELETE CASCADE ON UPDATE CASCADE;     -- ONLY USE WHEN THERE IS A NEED. YPU CAN ALSO SET IT TO NULL(SET NULL)
GO
INSERT INTO Course (Code, Name, StudentID)
VALUES ('DBAS4002', 'Transactional SQL Programming', 1);
GO

