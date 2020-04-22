
USE Chinook;
GO

SELECT * FROM Employee;
GO
--sIMPLE IF Statement to give manager a raise and no raise to the surbodinate
--declare some variables nb: if employeeID is 1 then it's the manager, otherwise,
-- its surbordinates.. you can change the Employeeid nos to get different results
DECLARE  @reportsTo INT;
DECLARE @employeeId INT = 2;
DECLARE @name VARCHAR(32);
--concatenate first and last name
SELECT @reportsTo = ReportsTo, @name = CONCAT(FirstName, ' ' , LastName)
FROM Employee
WHERE EmployeeId = @employeeId
PRINT 'name = ' + @name;
PRINT 'reportsTo = ' +
      IIF(@reportsTo IS NULL, 'no one', CAST(@reportsTo AS VARCHAR));
--how to use it with an if statemen
IF @reportsTo IS NULL
    PRINT 'Big Raise for ' + @name;
ELSE
    PRINT 'No raise for ' + @name;

--THE BEGIN STATEMENT IS ONLY MANDATORY IF YOU HAVE MORE THAN ONE STATMENTS
-- IF @reportsTo IS NULL
-- BEGIN
--     PRINT 'Big Raise for ' + @name;
-- END
-- ELSE
-- BEGIN
--     PRINT 'No raise for ' + @name;
-- END
-- GO
--the IIF IS USED FOR INLINE STATEMENTS...

--lOOPSSS
--To loop through the employeeID inorder to get the records
--initialize the employeeID to zero then group it
DECLARE  @reportsTo INT;
DECLARE @employeeId INT = 0;
DECLARE @name VARCHAR(32);
DECLARE @line VARCHAR(80);  -- CREATE A NEW VARIABLE TO HOLD THE LENGTH OF THE LINE AND PRINT
--concatenate first and last name
SELECT TOP 1 @reportsTo = ReportsTo, @name = CONCAT(FirstName, ' ' , LastName),
             @employeeId = EmployeeId
FROM Employee
WHERE EmployeeId > @employeeId
ORDER BY EmployeeId;
WHILE @@ROWCOUNT > 0
BEGIN
--     PRINT 'row count ' + CAST(@@ROWCOUNT AS VARCHAR);
--NOW USING LOOP TO SELECT THE TOP 1 RECORD, THE LOOP IS BASED ON THE ROWCOUNT
    SET @line = 'name = ' + @name;
    SET @line += ', reportsTo = ' +
        IIF(@reportsTo IS NULL, 'no one', CAST(@reportsTo AS VARCHAR)); --An integer will be casted to a string
    --how to use it with an if statemenT
    IF @reportsTo IS NULL
        SET @line += ', Big Raise for ' + @name;
    ELSE
        SET @line += ', No raise for ' + @name;
    PRINT @line;

    SELECT TOP 1 @reportsTo = ReportsTo, @name = CONCAT(FirstName, ' ' , LastName),
                 @employeeId = EmployeeId
    FROM Employee
    WHERE EmployeeId > @employeeId
    ORDER BY EmployeeId;
END

-- VIEW OF WHAT you want the public to see( IE, ONLY SURBODINATES)
CREATE VIEW vw_PublicEmployeeInformation
AS
    SELECT EmployeeId FirstName,LastName,Email, Title
FROM Employee
WHERE ReportsTo IS NOT NULL ;
GO
SELECT * FROM vw_PublicEmployeeInformation;

--tO CREATE A VIEW WITH COMPLEX JOINS
--A view  to see to see all current invoices, with all the elements of the invoices and the person
--that ordered it
DROP VIEW vw_InvoiceInformation;
CREATE VIEW vw_InvoiceInformation
AS
    SELECT I.InvoiceId, InvoiceDate, Total, Name, Bytes, IL.UnitPrice,
           Quantity, FirstName,LastName, Email
    FROM Invoice I
    INNER JOIN InvoiceLine IL on I.InvoiceId = IL.InvoiceId
    INNER JOIN Track T on IL.TrackId = T.TrackId
    INNER JOIN Customer C on I.CustomerId = C.CustomerId;
GO
SELECT * FROM vw_InvoiceInformation;



