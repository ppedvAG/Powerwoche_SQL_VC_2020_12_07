-- Tabellenabfragen

USE Northwind


SELECT * -- alle Spalten

-- * nur f�r �bungen, nicht in der Realit�t verwenden!
-- DB kann sich ver�ndern; Spalten k�nnen hinzukommen....


SELECT *
FROM Customers


SELECT	  CustomerID
		, CompanyName
		, ContactName
--		, ....
FROM Customers



SELECT	  CustomerID AS Kundennummer
		, CompanyName AS Firmenname
		, ContactName AS Kontaktperson
--		, ....
FROM Customers




SELECT	  CustomerID AS CustomerID -- Sinn?
		, CompanyName
		, ContactName
--		, ....
FROM Customers


SELECT	  CompanyName
		, CustomerID
		, 'Testtext'
		, 100
		, 100*3
FROM Customers



SELECT	  Freight * 100 AS [hundertfache Frachtkosten]
FROM Orders



-- Netto-, Bruttofrachtkosten und MwSt


SELECT	  Freight AS [freight netto]
		, Freight*0.19 AS MwSt
		, Freight*1.19 AS Bruttofrachtkosten
FROM Orders