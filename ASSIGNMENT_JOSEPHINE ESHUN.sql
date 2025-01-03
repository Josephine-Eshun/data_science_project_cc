USE AdventureWorks2022
GO

--BY JOSEPHINE ESHUN
--FROM CENTRAL REGION
---FIRST ASSIGNMENT

--Q1. Which department has the highest salary
--Q2. Find the top 10 customer that do more purchases
--Q3. What is the average order value by country?
--Q4. What are the total sales for each product category?
--Q5. Which products has the least sales ?

--NB: Deadline is 07/11/2024 @ 9:00am

--Q1. Which department has the highest salary?

SELECT d.Name, 
MAX(eph.Rate) AS HighestSalary
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeePayHistory AS eph
ON e.BusinessEntityID = eph.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS edh
ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department AS d
ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY HighestSalary DESC

--Q2. Find the top 10 customer that do more purchases
SELECT TOP 10 c.CustomerID AS Customer,
SUM (soh.TotalDue) AS TotalPurchases
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c
ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID 
ORDER BY TotalPurchases DESC

--Q3. What is the average order value by country?
SELECT cr.Name AS COUNTRIES,
	AVG(sod.OrderQty) AS ORDERS
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
JOIN Sales.SalesTerritory AS st
ON soh.TerritoryID = st.TerritoryID
JOIN Person.CountryRegion AS cr
ON st.CountryRegionCode = cr.CountryRegionCode
GROUP BY cr.Name
ORDER BY ORDERS DESC

--Q4. What are the total sales for each product category?
SELECT TOP 10 p.Name AS ProductCategory,
SUM(sod.LineTotal) AS TotalSales
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
ON  ps.ProductCategoryID = pc.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
GROUP BY p.Name

--Q5. Which products has the least sales ?
SELECT p.ProductID, p.Name AS ProductName,
SUM(sod.LineTotal) AS TotalSales
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalSales ASC