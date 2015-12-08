Use TelerikAcademy
--Problem 1 Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company. 
SELECT FirstName, LastName, Salary
 FROM Employees 
 WHERE Salary = 
 (SELECT MIN(Salary) FROM Employees)

 --Problem 2 Write a SQL query to find the names and salaries of the employees
 -- that have a salary that is up to 10% higher than the minimal salary for the company.
 SELECT FirstName, LastName, Salary
 FROM Employees
 WHERE Salary <
			(SELECT MIN(SALARY) FROM Employees) * 1.1

 --Problem 3 Write a SQL query to find the full name, salary and department of the employees
 --that take the minimal salary in their department.
 SELECT e.FirstName + ' ' + e.LastName AS [Name], e.Salary, d.Name
 FROM Employees e
 JOIN Departments d ON d.DepartmentID = e.DepartmentID
 WHERE e.Salary = 
				(SELECT MIN(Salary)
				FROM Employees
				WHERE DepartmentID = e.DepartmentID)
ORDER BY e.Salary

--Problem 4 Write a SQL query to find the average salary in the department #1.
SELECT AVG(Salary)
FROM Employees
WHERE DepartmentID = 1 

--Problem 5 Write a SQL query to find the average salary in the "Sales" department.
SELECT AVG(Salary)
FROM Employees
WHERE DepartmentID =
				 (SELECT DepartmentID FROM Departments WHERE Name = 'Sales')

--Problem 6 Write a SQL query to find the number of employees in the "Sales" department.
SELECT Count(*)
FROM Employees
WHERE DepartmentID =
				 (SELECT DepartmentID FROM Departments WHERE Name = 'Sales')

--Problem 7 Write a SQL query to find the number of all employees that have manager.
SELECT Count(ManagerID)
FROM Employees

--Problem 8 Write a SQL query to find the number of all employees that have no manager.
SELECT Count(*)
FROM Employees
WHERE ManagerID IS NULL

--Problem 9 Write a SQL query to find all departments and the average salary for each of them.
SELECT d.Name, AVG(e.Salary) AS [Average salary]
FROM Employees e
			JOIN Departments d
			 ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name

--Problem 10 Write a SQL query to find the count of all employees in each department and for each town.
SELECT COUNT(e.FirstName) AS [Amount Of Employees], d.Name AS [Department Name],  t.Name AS [Town Name]
FROM Employees e
			JOIN Departments d
			 ON d.DepartmentID = e.DepartmentID
			 JOIN Addresses a
			 On a.AddressID = e.AddressID
			 JOIN Towns t
			 ON t.TownID = a.TownID
GROUP BY d.Name, t.Name

--Problem 11 Write a SQL query to find all managers that have exactly 5 employees.
--Display their first name and last name.
SELECT m.FirstName AS [Managers with 5 Subservents]
FROM Employees e
			JOIN Employees m
			 ON m.ManagerID = e.ManagerID
GROUP BY m.FirstName
HAVING COUNT(m.EmployeeID) = 5

--Problem 12 Write a SQL query to find all employees along with their managers.
--For employees that do not have manager display the value "(no manager)".
SELECT e.FirstName AS [Employee], ISNULL(m.FirstName, 'no manager') AS [Manager]
FROM Employees e
			LEFT OUTER JOIN Employees m
			 ON m.ManagerID = e.ManagerID
GROUP BY m.FirstName, e.FirstName

--Problem 13 Write a SQL query to find the names of all employees whose last name
--is exactly 5 characters long. Use the built-in LEN(str) function.
SELECT LastName
FROM Employees
WHERE LEN(LastName) = 5

--Problem 14 Write a SQL query to display the current date and time
--in the following format "day.month.year hour:minutes:seconds:milliseconds". 
SELECT CONVERT(VARCHAR(24), GETDATE(), 13) AS [Current Time]


--Problem 15 Write a SQL statement to create a table Users.
--Users should have username, password, full name and last login time.

--Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
--Define the primary key column as identity to facilitate inserting records.
--Define unique constraint to avoid repeating usernames.
--Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users
(
UserId int IDENTITY(1,1) PRIMARY KEY,
Username nvarchar(36) UNIQUE NOT NULL,
Password nvarchar(128) CHECK (DATALENGTH([Password]) >= 5) NOT NULL,
Fullname nvarchar(68) NOT NULL,
Last_login datetime
)
INSERT INTO Users (Username, Password, Fullname)
VALUES('Test', 'Guest', 'Tom Brady')
SELECT * FROM Users
GO

--Problem 16  Write a SQL statement to create a view
--that displays the users from the Users table that have been in the system today. 
CREATE VIEW [Last login]
 AS
SELECT Username, Last_login
FROM Users
GO

--Problem 17  Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint).
CREATE TABLE Groups
(
groupID int PRIMARY KEY IDENTITY(1,1),
name nvarchar(26) UNIQUE NOT NULL
)
INSERT INTO Groups (name)
VALUES('Telerik study group')
GO

--Problem 18 Write a SQL statement to add a column GroupID to the table Users.
--Fill some data in this new column and as well in the `Groups table.
--Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
ALTER TABLE Users
ADD GroupID int NOT NULL

ALTER TABLE Users
ADD CONSTRAINT FK_Users_Groups
FOREIGN KEY (GroupID)
REFERENCES Groups(GroupID)

--Problem 19 Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Users(Username, Fullname, Password, Last_login)
VALUES('JON DOE','Mike Tomson', 'GUEST123', GETDATE()),
('JANE DOE','Judy Tomson', 'GUEST321', GETDATE()),
 ('JONNYE DOE','Blob Tomson', 'GUEST666', GETDATE())

 INSERT INTO Groups(Name)
 VALUES ('TimeSpan'),
  ('Khans'),
  ('Crack')

  SELECT * FROM Users
  SELECT * FROM Groups

--Problem 20 Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET Username = 'You got hacked fool'
WHERE UserId = 4

UPDATE Groups
SET Name = 'Pay your rent bumms'
WHERE groupID = 4

--Problem 21  Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Users
WHERE UserId = 2

DELETE FROM Groups
WHERE groupID = 2

-- Problem 22 Write SQL statements to insert in the Users table the names of all employees
-- from the Employees table.
--Combine the first and last names as a full name.
--For username use the first letter of the first name + the last name (in lowercase).
--Use the same for the password, and NULL for last login time.

INSERT INTO Users(Username, Fullname, Password, Last_login)
SELECT LOWER(LEFT(FirstName, 1)) + LOWER(LastName),
     FirstName + ' ' + LastName,
	 LOWER(LEFT(FirstName, 1)) + LOWER(LastName),
	 NULL
FROM Employees

SELECT * FROM Users

--Problem 23 Write a SQL statement that changes the password to NULL 
--for all users that have not been in the system since 10.03.2010.
UPDATE Users
SET Password = NULL
WHERE Last_login < CONVERT(datetime, '10.03.2010')

--Problems 24 Write a SQL statement that deletes all users without passwords (NULL password).
DELETE Users
WHERE Password = NULL

--Problems 25 Write a SQL query to display the average employee salary by department and job title
SELECT AVG(e.Salary) AS [Employee salary], d.Name AS [Department], e.JobTitle AS [Position]
FROM Employees e
           JOIN Departments d ON D.departmentID = e.DepartmentID
GROUP BY e.Salary, d.Name, e.JobTitle

--Problem 26 Write a SQL query to display the minimal employee salary
--by department and job title along with the name of some of the employees that take it.
SELECT MIN(e.Salary) AS [Employee salary],
			  d.Name AS [Department],
		  e.JobTitle AS [Position],
		 e.FirstName AS [Name Of The Looser]
FROM Employees e
           JOIN Departments d ON D.departmentID = e.DepartmentID
GROUP BY e.Salary, d.Name, e.JobTitle, e.FirstName

--Problem 27 Write a SQL query to display the town where maximal number of employees work.
SELECT TOP 1 t.Name AS [Town], COUNT(*) AS [Amount Of Employees]
FROM Employees e 
			JOIN Addresses a
			 ON a.AddressID = e.AddressID
			JOIN Towns t 
			 ON t.TownID = a.TownID
GROUP BY t.Name

--Problem 28 Write a SQL query to display the number of managers from each town.
SELECT  t.Name AS [Town], COUNT(*) AS [Amount Of Managers]
FROM Employees e
			JOIN Employees m
			 ON e.ManagerID = m.ManagerID 
			JOIN Addresses a
			 ON a.AddressID = e.AddressID
			JOIN Towns t 
			 ON t.TownID = a.TownID
GROUP BY t.Name

--Problem 29 Write a SQL to create table WorkHours to store work
--reports for each employee (employee id, date, task, hours, comments).

--Don't forget to define identity, primary key and appropriate foreign key.
--Issue few SQL statements to insert, update and delete of some data in the table.
--Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
--For each change keep the old record data, the new record data and the command (insert / update / delete).
CREATE TABLE WorkHours
(
Id int IDENTITY(1,1) NOT NULL,
Date date,
Task nvarchar(32) NOT NULL,
Hours int NOT NULL,
Comment nvarchar(64),
EmployeeID int
CONSTRAINT PK_WorkHours PRIMARY KEY(id)
CONSTRAINT PK_WorkHours_Employees FOREIGN KEY(EmployeeID)
REFERENCES Employees(EmployeeID)
)

INSERT INTO WorkHours (date, task, hours, comment, EmployeeID)
VALUES('10.03.2010', 'Do Work', '8', 'Dhamn this is boring', 1),
	  ('11.03.2010', 'Do More Work', '12', 'Dhamn this is harder', 2),
	  ('12.03.2010', 'Do No Work', '0', 'Dhamn this is easy', 3)

UPDATE WorkHours
SET task = 'Boring task'
WHERE id = 1

DELETE WorkHours
WHERE hours = 0

CREATE TABLE WorkHoursLogs
(
	LogId INT IDENTITY(1,1),
	OldRecord nvarchar(200),
	NewRecord nvarchar(200),
	Command nvarchar(10),
	EmployeeID INT,
	CONSTRAINT PK_WorkHoursLogs PRIMARY KEY(LogId),
)
GO

CREATE TRIGGER tr_WorkHoursInsert
 ON WorkHours
  FOR 
  INSERT
   AS
	INSERT INTO WorkHoursLogs(OldRecord, NewRecord, Command, EmployeeId)
	VALUES('',
		   (SELECT 'Day: ' + CAST(Date AS nvarchar(50)) + ' ' + ' Task: ' + Task + ' ' + 
					' Hours: ' + CAST([Hours] AS nvarchar(50)) + ' ' + Comment
			FROM Inserted),
		   'INSERT',
		   (SELECT EmployeeID FROM Inserted))
GO

CREATE TRIGGER tr_WorkHoursUpdate
 ON WorkHours
 FOR UPDATE 
 AS
	INSERT INTO WorkHoursLogs(OldRecord, NewRecord, Command, EmployeeId)
	VALUES((SELECT 'Day: ' + CAST(Date AS nvarchar(50)) + ' ' + ' Task: ' + Task + ' ' +
					 ' Hours: ' + CAST([Hours] AS nvarchar(50)) + ' ' + Comment FROM Deleted),
		   (SELECT 'Day: ' + CAST(Date AS nvarchar(50)) + ' ' + ' Task: ' + Task + ' ' + 
					' Hours: ' + CAST([Hours] AS nvarchar(50)) + ' ' + Comment FROM Inserted),
		   'UPDATE',
		   (SELECT EmployeeID FROM Inserted))
GO

CREATE TRIGGER tr_WorkHoursDelete
 ON WorkHours
  FOR DELETE
   AS
	INSERT INTO WorkHoursLogs(OldRecord, NewRecord, Command, EmployeeId)
	VALUES((SELECT 'Day: ' + CAST(Date AS nvarchar(50)) + ' ' + ' Task: ' + Task + ' ' + 
					' Hours: ' + CAST([Hours] AS nvarchar(50)) + ' ' + Comment FROM Deleted),
		   '',
		   'DELETE',
		   (SELECT EmployeeID FROM Deleted))
GO

--Problem 30 Start a database transaction, delete all employees from the 'Sales' department
-- along with all dependent records from the pother tables.
--At the end rollback the transaction.
BEGIN TRAN
		ALTER TABLE Employees
		DROP CONSTRAINT FK_Employees_Departments
 DELETE d
 FROM Departments d
 WHERE d.Name = 'Sales'
ROLLBACK TRAN

--Problem 31 Start a database transaction and drop the table EmployeesProjects.
--Now how you could restore back the lost table data?
BEGIN TRAN
DROP TABLE EmployeesProjects --OMG ALL THE TABLES ARE GONEEE
ROLLBACK TRAN -- THEY ARE BACKKKK

--Problem 32 Find how to use temporary tables in SQL Server.
--Using temporary tables backup all records from EmployeesProjects and restore them back
--after dropping and re-creating the table.
CREATE TABLE #TemporaryTable
(
	EmployeeId INT,
	ProjectId INT
)


INSERT INTO #TemporaryTable
SELECT EmployeeId, ProjectId
FROM EmployeesProjects

DROP TABLE EmployeesProjects

CREATE TABLE EmployeesProjects
(
	EmployeeId INT,
	ProjectId INT,
	CONSTRAINT PK_EmployeesProjects PRIMARY KEY(EmployeeID, ProjectID),
	CONSTRAINT FK_EmployeesProjects_Employees FOREIGN KEY(EmployeeID) 
	REFERENCES Employees(EmployeeID),
	CONSTRAINT FK_EmployeesProjects_Projects FOREIGN KEY(ProjectID) 
	REFERENCES Projects(ProjectID)
)

INSERT INTO EmployeesProjects
SELECT EmployeeId, ProjectId
FROM #TemporaryTable