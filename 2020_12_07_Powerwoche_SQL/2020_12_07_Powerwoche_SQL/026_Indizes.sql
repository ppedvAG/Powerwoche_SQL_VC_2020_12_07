-- idexes
-- Indices, Indizes


-- Clustered Index (gruppierter Index)
		-- 1 pro Tabelle 
		-- verantwortlich dafür, wie die Daten physisch auf dem Datenträger abgespeichert werden

-- Nonclustered Index (nicht gruppierter Index)
		-- unique index (eindeutiger Index)
		-- multicolumn index (zusammengesetzter Index)
		-- covering index (abdeckender Index)
		-- filtered index (gefilterter Index)
		-- index with included columns (Index mit eingeschlossenen Spalten)

		-- hypothetisch realer Index


-- columnstore index  --> Data Warehouse


-- page hat ~ 8KB
-- davon entfallen 96 byte auf den header
-- jeweils 2 byte pro Datensatz = row offset
-- jeweils 7 byte pro Datensatz overhead



-- welche Indizes sind in der aktuellen DB vorhanden?
SELECT * FROM sys.indexes







SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderID, Orders.CustomerID AS Expr1, Orders.EmployeeID, Employees.EmployeeID AS Expr2, Employees.LastName, 
             Employees.FirstName, Employees.BirthDate, [Order Details].OrderID AS Expr3, [Order Details].ProductID, [Order Details].Quantity, Products.ProductID AS Expr4, Products.ProductName
INTO ku
FROM   Customers INNER JOIN
             Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
             Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
             [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
             Products ON [Order Details].ProductID = Products.ProductID



-- > mehr Daten zum Testen:

insert into ku
select * from ku
GO 9


select * from ku



SELECT COUNT(*) from ku


SELECT TOP 3 * FROM ku


SET STATISTICS IO, TIME ON


SELECT *
INTO ku2
FROM ku


SELECT * FROM ku2


SELECT * from ku2
WHERE Country = 'Germany'


ALTER TABLE ku2
ADD kid int identity


SELECT kid
FROM ku2
WHERE kid = 1000

-- erstellen index auf kid  NCIX_kid


SELECT kid
FROM ku2
WHERE kid = 1000



-- zusätzliche Spalte:
SELECT	  kid
		, CompanyName
FROM ku2
WHERE kid = 1000

-- Company Name ist Lookup (Heap) - wie ein Scan
--> neuer Index


SELECT	  kid
		, CompanyName
FROM ku2
WHERE kid = 1000



-- noch mehr Spalten:
SELECT	  kid
		, CompanyName
		, Country
		, City
FROM ku2
WHERE kid = 1000



