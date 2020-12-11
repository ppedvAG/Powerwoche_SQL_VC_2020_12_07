-- Maxdop

-- MAXimum Degree Of Paralellism


-- wieviele CPUs dürfen maximal für eine Abfrage verwendet werden


SET STATISTICS IO, TIME ON


SELECT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country, Orders.OrderID, Orders.CustomerID AS Expr1, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, Employees.EmployeeID AS Expr2, Employees.LastName, Employees.FirstName, 
             Employees.BirthDate, Products.ProductID, Products.ProductName, Products.UnitPrice, [Order Details].OrderID AS Expr3, [Order Details].ProductID AS Expr4, [Order Details].UnitPrice AS Expr5, [Order Details].Quantity
INTO ku3
FROM   Customers INNER JOIN
             Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
             Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
             [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
             Products ON [Order Details].ProductID = Products.ProductID


insert into ku3
select * from ku3
GO 9



SELECT CompanyName, SUM(UnitPrice*Quantity)
FROM ku3
WHERE CompanyName LIKE 'A%'
GROUP BY CompanyName




