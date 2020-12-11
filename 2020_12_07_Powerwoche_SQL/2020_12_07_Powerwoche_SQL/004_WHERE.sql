-- Bedingungen abfragen mit WHERE
-- einschränken, welche Ergebnisse zurückgegeben werden


/*
	WHERE Operatoren

	=, <, >, <=, >=

	!=, <> ........... darf NICHT einem bestimmten Wert entsprechen

	IS, IS NOT

	-- positiv formulieren macht Abfrage schneller
	-- NOT nur verwenden, wenns nicht anders geht


	AND -- es müssen zwingend alle Bedingungen erfüllt sein
	OR -- mindestens eine der Bedingungen muss erfüllt sein


	IN, BETWEEN



*/


-- einschränken

SELECT	  CustomerID
		, CompanyName
		, Country
	--  , ....
FROM Customers
WHERE Country = 'Germany'




SELECT	  CustomerID
		, CompanyName
		, Country
	--  , ....
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'



-- alle deutschsprachigen Kunden

SELECT	  CustomerID
		, CompanyName
		, Country
		, Region
	--  , ....
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria' OR Country = 'Switzerland'




-- ein bestimmter Wert darf nicht zutreffen
SELECT *
FROM Orders
WHERE Freight != 148.33

-- positiv formuliert
SELECT *
FROM Orders
WHERE Freight < 148.33 OR Freight > 148.33



-- *********************** IN *********************************



SELECT	  CustomerID
		, CompanyName
		, Country
		, Region
	--  , ....
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')


-- Alle Angestellten mit der Nummer 3, 5, 7

SELECT *
FROM Employees
WHERE EmployeeID IN(3, 5, 7)



-- Bereiche abfragen

-- alle Bestellungen, wo Frachtkosten mindestens 100 und maximal 200 sind

SELECT	  OrderID
		, Freight
--		, ...
FROM Orders
WHERE Freight >= 100 AND Freight <= 200



SELECT	  OrderID
		, Freight
--		, ...
FROM Orders
WHERE Freight BETWEEN 100 AND 200
-- BETWEEN macht >= und <=


-- die, die größer 100 und kleiner 200 sind
SELECT	  OrderID
		, Freight
--		, ...
FROM Orders
WHERE Freight > 100 AND Freight < 200


-- alle Produkte zwischen ProduktID zwischen 10 und 15 (inklusive)

SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15


-- alle Produkte, die von den Anbietern 2, 7 und 15 geliefert werden
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)
