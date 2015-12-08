-- Problem 1 Create a database with two tables: Persons(Id(PK), FirstName, LastName, SSN) and Accounts(Id(PK), PersonId(FK), Balance).
   --Insert few records for testing.
   --Write a stored procedure that selects the full names of all persons.

CREATE DATABASE BankSystem

CREATE TABLE Persons (
PersonID INT IDENTITY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
SSN NVARCHAR(50),
CONSTRAINT PK_PersonID PRIMARY KEY (PersonID)
)

CREATE TABLE Accounts (
AccountID INT IDENTITY,
PersonID INT NOT NULL,
Balance MONEY NOT NULL,
CONSTRAINT PK_AccountID PRIMARY KEY (AccountID),
CONSTRAINT FK_Accounts_People_PersonID FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
)

GO

USE [BankSystem]

INSERT INTO Persons
	(FirstName,LastName,SSN)
VALUES 
	('John','Doe','123'),
	('Jane','Doe','321'),
GO
INSERT INTO Accounts
	(PersonID,Balance)
VALUES 
	(1, 2000),
	(2, 6500),
GO
-- Problem 2 Create a stored procedure that accepts a number as a parameter and returns all persons who have more money in their accounts than the supplied number.

CREATE PROC usp_PeopleWithHigherBalance @accBalanceTolerance MONEY = 0
AS
SELECT p.FirstName, p.LastName, a.Balance
 FROM Persons p
  JOIN Accounts a 
                                  ON p.PersonID = a.PersonID
WHERE a.Balance > @accBalanceTolerance
GO

EXEC usp_PeopleWithHigherBalance @accBalanceTolerance = 3000

GO

-- Problem 3 Create a function that accepts as parameters – sum, yearly interest rate and number of months.
    --It should calculate and return the new sum.
    --Write a SELECT to test whether the function works as expected.

CREATE FUNCTION ufn_CalculateSumWithInterest (@sum MONEY, @yearInterest DECIMAL, @numberOfMonths INT) RETURNS MONEY
AS
BEGIN
RETURN (@sum + @sum * (@yearInterest / 100)*@numberOfMonths / 12)
END
GO


DECLARE @sum MONEY = (SELECT Balance FROM Accounts WHERE AccountID = 1)
PRINT dbo.ufn_CalculateSumWithInterest(@sum,10,10)


GO
--Problem 4 Create a stored procedure that uses the function from the previous example to give an interest to a person's account for one month.
    --It should take the AccountId and the interest rate as parameters.

CREATE PROC usp_AddInterestForOneMonth (@accountID INT, @interest DECIMAL)
AS
DECLARE @sum MONEY = (SELECT Balance FROM Accounts WHERE AccountID = @accountID)
UPDATE Accounts
SET Balance = (@sum+@sum*(@interest/100)/12)
WHERE AccountID = @accountID
GO

EXEC usp_AddInterestForOneMonth 1, 10
GO
--Problem 5 Add two more stored procedures WithdrawMoney(AccountId, money) and DepositMoney(AccountId, money) that operate in transactions.

CREATE PROC usp_WithdrawMoney (@accountID INT, @money MONEY)
AS
DECLARE @currentBalanace MONEY = (SELECT Balance FROM Accounts WHERE AccountID = @accountID)
IF(@money <= @currentBalanace)
BEGIN
UPDATE Accounts
SET Balance = Balance-@money
WHERE AccountID = @accountID
END
ELSE
BEGIN
PRINT 'An error occured'
END 
GO

GO
CREATE PROC usp_DepositMoney (@accountID INT, @money MONEY)
AS
UPDATE Accounts
SET Balance = Balance+@money
WHERE AccountID = @accountID
GO

EXEC usp_WithdrawMoney 4, 5000
EXEC usp_DepositMoney 4,5000

--Problem 6 Create another table – Logs(LogID, AccountID, OldSum, NewSum).
    --Add a trigger to the Accounts table that enters a new entry into the Logs table every time the sum on an account changes.

CREATE TABLE Logs(
LogID INT IDENTITY,
AccountID INT,
OldSum MONEY,
NewSum MONEY,
CONSTRAINT PK_LogID PRIMARY KEY (LogID))
GO

CREATE TRIGGER Tr_AccountUpdate
ON Accounts
FOR UPDATE
AS
SET NOCOUNT ON
INSERT INTO Logs
SELECT
i.AccountID,
d.Balance,
i.Balance
FROM INSERTED i, DELETED d
GO

--Problem 7 Define a function in the database TelerikAcademy that returns all Employee's names
    --(first or middle or last name) and all town's names that are comprised of given set of letters.
    --Example: 'oistmiahf' will return 'Sofia', 'Smith', … but not 'Rob' and 'Guy'.


USE TelerikAcademy
GO
CREATE FUNCTION ufn_CheckName (@nameToCheck NVARCHAR(50),@letters NVARCHAR(50)) RETURNS INT
AS
BEGIN
    DECLARE @i INT = 1
	DECLARE @currentChar NVARCHAR(1)
    WHILE (@i <= LEN(@nameToCheck))
		BEGIN
		SET @currentChar = SUBSTRING(@nameToCheck,@i,1)
			IF (CHARINDEX(LOWER(@currentChar),LOWER(@letters)) <= 0) 
			BEGIN  
			RETURN 0
			END
			SET @i = @i + 1
			END
            RETURN 1
            END
GO


--WITH WHERE AS TABLE
SELECT e.FirstName, e.LastName,t.Name FROM Employees e
JOIN Addresses a ON e.AddressID = a.AddressID
JOIN Towns t ON a.TownID=t.TownID
WHERE 
dbo.ufn_CheckName(e.FirstName,'oistmiahf') = 1 OR 
dbo.ufn_CheckName(e.LastName,'oistmiahf') = 1 OR
dbo.ufn_CheckName(t.Name,'oistmiahf') = 1

--WITH CURSOR AS PRINT
DECLARE employeeTownCursor CURSOR READ_ONLY FOR
  (SELECT e.FirstName, e.LastName, t.Name FROM Employees e
  JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID=t.TownID)

OPEN employeeTownCursor
DECLARE @firstName NVARCHAR(50), @lastName NVARCHAR(50), @town NVARCHAR(50)
DECLARE @searchString NVARCHAR(50) ='oistmiahf'
FETCH NEXT FROM employeeTownCursor INTO @firstName, @lastName, @town

WHILE @@FETCH_STATUS = 0
  BEGIN
    IF(dbo.ufn_CheckName(@firstName,@searchString)=1)
		BEGIN
			PRINT 'First name: ' + @firstName
		END
	IF(dbo.ufn_CheckName(@lastName,@searchString)=1)
		BEGIN
			PRINT 'Last name: ' + @lastName
		END
	IF(dbo.ufn_CheckName(@town,@searchString)=1)
		BEGIN
			PRINT 'Town: ' + @town
		END
	FETCH NEXT FROM employeeTownCursor INTO @firstName, @lastName, @town
  END

CLOSE employeeTownCursor
DEALLOCATE employeeTownCursor

--Problem 8 Using database cursor write a T-SQL script that scans all employees
   --and their addresses and prints all pairs of employees that live in the same town.
DECLARE employeeTownCursor CURSOR READ_ONLY FOR
  (SELECT e.FirstName, e.LastName, t.Name FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID=t.TownID)


OPEN employeeTownCursor
DECLARE @firstName NVARCHAR(50), @lastName NVARCHAR(50), @town NVARCHAR(50)

FETCH NEXT FROM employeeTownCursor INTO @firstName, @lastName,@town

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE employeeTownCursor1 CURSOR READ_ONLY FOR
		(SELECT e.FirstName, e.LastName, t.Name FROM Employees e
		JOIN Addresses a ON e.AddressID = a.AddressID
		JOIN Towns t ON a.TownID=t.TownID)
	OPEN employeeTownCursor1
		DECLARE @firstName1 NVARCHAR(50), @lastName1 NVARCHAR(50), @town1 NVARCHAR(50)
		FETCH NEXT FROM employeeTownCursor1 INTO @firstName1, @lastName1,@town1
			WHILE @@FETCH_STATUS = 0
			BEGIN
		
				IF(@town = @town1)
				BEGIN
					PRINT @lastname1 + ': ' + @firstname + ' ' +  @lastname + ' ' + @town + ' ' + @firstname1 
				END

			FETCH NEXT FROM employeeTownCursor1 INTO @firstName1, @lastName1,@town1
			END

	CLOSE employeeTownCursor1
	DEALLOCATE employeeTownCursor1

FETCH NEXT FROM employeeTownCursor INTO @firstName, @lastName,@town
END

CLOSE employeeTownCursor
DEALLOCATE employeeTownCursor

--Problem 9 Write a T-SQL script that shows for each town a list of all employees that live in it. 
use TelerikAcademy
DECLARE townEmployeesCursor CURSOR READ_ONLY FOR
(SELECT t.Name, dbo.StrConcat(FirstName + ' ' + LastName) AS [List of employees] FROM Employees e
JOIN Addresses a ON a.AddressID = e.AddressID
JOIN Towns t ON t.TownID = a.TownID
GROUP BY t.Name)

OPEN townEmployeesCursor
DECLARE @town NVARCHAR(50), @list NVARCHAR(MAX)

FETCH NEXT FROM townEmployeesCursor INTO @town, @list

WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT @town + ' -> '+@list
	FETCH NEXT FROM townEmployeesCursor INTO @town, @list
  END

CLOSE townEmployeesCursor
DEALLOCATE townEmployeesCursor