-- VIEW (Sichten)


CREATE VIEW v_Customers_Contacts
AS
SELECT	CustomerID
		, CompanyName
		, ContactName
		, Phone
		, Address
		, PostalCode
		, City
		, Country
FROM Customers
GO


SELECT CompanyName, ContactName, Phone
FROM v_Customers_Contacts


SELECT CompanyName
FROM v_Customers_Contacts
WHERE CompanyName LIKE 'a%'



-- DROP VIEW v_Customers_Contacts


-- Rechnung
CREATE VIEW v_Rechnungen
AS
SELECT	  c.CustomerID
		, c.CompanyName
--		, .....
		, o.OrderID
		, o.OrderDate
--		, ....
		, od.Quantity
		, p.ProductName
--		, .....
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
-- WHERE Country = 'Austria'
GO