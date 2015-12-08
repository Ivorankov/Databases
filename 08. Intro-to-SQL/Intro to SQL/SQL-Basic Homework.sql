USE TelerikAcademy
--Problem 4 Select all departments
SELECT * FROM Departments

--Problem 5 Select all department names
SELECT Name FROM Departments

--Problem 6 Find all employee salaries
SELECT Salary FROM Employees

--Problem 7 Extract full name of all employees
SELECT FirstName + ' ' + LastName FROM Employees

--Problem 8 Construct table containing emails of all employees
SELECT FirstName + '.' + LastName + '@telerik.com' AS [Full Email Adresses] FROM Employees 

--Problem 9 Find all different employee salaries
SELECT DISTINCT Salary FROM Employees

--Problem 10 Find all employees with job title
SELECT * FROM Employees WHERE JobTitle = 'Sales Representative'

--Problem 11 Find all employees where theyr first name starts with SA
SELECT * FROM Employees WHERE FirstName LIKE 'SA%'

--Problem 12 Find all employees where theyr last name ends with SA
SELECT * FROM Employees WHERE LastName LIKE '%ei'

--Problem 13 Find all employee names with salaries in range 20-30k
SELECT FirstName + ' ' + LastName AS [Middle Class] FROM Employees WHERE Salary BETWEEN 20000 AND 30000

-- Problem 14 Find all employees whos salary is 25k or 14k 12.5k or 23.6k
SELECT FirstName + ' ' + LastName AS [People to Be Fired muhahah] FROM Employees WHERE Salary IN (12500, 14000, 23600, 25000)

--Problem 15 Find all employees that don't have a manager
SELECT * FROM Employees WHERE ManagerID Is NULL

--Problem 16 Find all employees with salary over 50k and sort in desc order
SELECT * FROM Employees WHERE Salary > 50000 ORDER BY Salary DESC

--Problem 17 Find top 5 paied employees
SELECT TOP 5 * FROM  Employees ORDER BY Salary DESC

--Problem 18 Select all employees with theyr addresses
SELECT e.FirstName, e.LastName, a.AddressText FROM Employees e INNER JOIN Addresses a ON e.AddressID = a.AddressID

--Problem 19 Select all employees with theyr addresses
SELECT e.FirstName, e.LastName, a.AddressText FROM Employees e, Addresses a WHERE e.AddressID = a.AddressID

--Problem 20 Select all employees and theyr managers
SELECT e.FirstName + ' ' + e.LastName AS [Employee], e.FirstName +' ' + e.LastName AS [Manager]
 FROM Employees e JOIN Employees m
  ON  m.ManagerID = e.ManagerID

-- Problem 21 Select all employees and they manager and address
SELECT e.FirstName + ' ' + e.LastName AS [Employee], m.FirstName + ' ' + m.LastName AS [Manager], a.AddressText AS [Employee Address]
FROM Employees e JOIN Employees m ON e.ManagerID = m.ManagerID JOIN Addresses a ON e.AddressID = a.AddressID

--Problem 22 Find all departments and towns as a single list
SELECT Name FROM Departments UNION SELECT Name FROM Towns

--Problem 23 Find all employees and the managers for each of them using RIGHT/LEFT OUTER JOIN
SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees m RIGHT OUTER JOIN Employees e ON e.ManagerID = m.EmployeeID 


SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees e LEFT OUTER JOIN Employees m ON e.ManagerID = m.EmployeeID

--Problem 24 Find all employees names from departments Sales and Finance who were hired between 1995 and 2005
SELECT e.FirstName, e.LastName, d.Name AS [Department], e.HireDate
 FROM Employees e
  JOIN Departments d
   ON (e.DepartmentID = d.DepartmentID
   AND  d.Name IN ('Sales', 'Finance')
   AND e.HireDate BETWEEN '1995-01-01' AND '2005-12-31')
   
   GO
