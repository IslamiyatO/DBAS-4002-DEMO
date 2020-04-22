
USE StudentDemo;
GO

SELECT * FROM Student;
GO

CREATE PROCEDURE usp_GetStudents
AS
BEGIN
    SELECT * FROM Student;
END;
GO

--Calling a procedure
EXEC dbo.usp_GetStudents;
GO

--Modifying procedures - drop and recreate the procedure
DROP PROCEDURE usp_GetStudents;
GO
CREATE PROCEDURE usp_GetStudents
    @age SMALLINT
AS
BEGIN
    SELECT * FROM Student
    WHERE Age > @age;
END;
GO

EXEC usp_GetStudents 18;
GO

--CREATE A NEW PROCEDURE TO GET STUDENTS THAT HAVE A PARTICULAR FIRSTNAME & LASTNAME
--Passing values to the procedures
DROP PROCEDURE usp_GetStudents;
GO
CREATE PROCEDURE usp_GetStudentsByName
    @FirstName NVARCHAR(32), @LastName NVARCHAR(32)
AS
BEGIN
    SELECT FirstName,LastName FROM Student
    WHERE FirstName LIKE @FirstName OR LastName LIKE @LastName;
END;
GO
-- This gives names of people with firstname starting with letter J & lastName starting
-- letter S.
EXEC usp_GetStudentsByName N'J%' , N'S%';
GO

--tO GET THE AVERAGE AGE BEFORE INPUTTING IT
SELECT AVG(Age) AS AverageAge FROM Student;
GO

--To return a value from the procedures
DROP PROCEDURE usp_GetStudentAverageAge;

CREATE PROCEDURE usp_GetStudentAverageAge
    @averageAge SMALLINT OUTPUT
AS
BEGIN
    SET @averageAge = (SELECT AVG(Age) FROM Student);
END;
GO
--Declare a variable to store the return value in
DECLARE @avg SMALLINT;
EXEC usp_GetStudentAverageAge @avg OUTPUT ;
PRINT 'avg = ' + STR(@avg);
GO

--User Defined Function
--Get the average using function
CREATE FUNCTION ufn_GetStudentAverageAge()
RETURNS SMALLINT
AS
BEGIN
    DECLARE @avg SMALLINT;
    SET @avg = (SELECT AVG(Age) FROM Student);
    RETURN @avg;
END;
GO

--To call it
DECLARE @avg SMALLINT;
EXEC @avg = ufn_GetStudentAverageAge;
PRINT 'avg = ' + STR(@avg);
GO



