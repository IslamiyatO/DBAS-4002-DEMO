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