-- Subquery
-- Unterabfrage, Subselect


-- wie eine Spalte, wie eine Tabelle oder im WHERE verwenden


-- Subquery wie Spalte verwenden

SELECT	  'Text'
		, 123
		, Freight
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight) AS [niedrigste Frachtkosten]
FROM Orders
-- wenn Unterabfrage wie eine Spalte verwendet wird, darf da nur 1 Wert drinstehen




-- Subquery wie Tabelle (als Datenquelle) verwenden

SELECT *
FROM -- Tabellenname
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) AS T
-- wenn wir eine Unterabfrage als Datenquelle verwenden, müssen wir ein ALIAS vergeben (das AS darf wieder weggelassen werden)


-- Subquery im WHERE
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442

-- hier muss auch ein konkreter Wert herauskommen, damit wir den Vergleich Freight > ... anstellen können

-- mit AND, OR kombinierbar

SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND ShipCountry = 'Germany'



-- alle Kunden, die in einem Land wohnen, in das auch Bestellungen verschifft werden
SELECT	  CustomerID
		, CompanyName
		, Country
FROM Customers
WHERE Country IN(SELECT ShipCountry FROM Orders)



-- Namen und Einstellungsdatum aller Mitarbeiter, die im selben Jahr eingestellt wurden wie Mr. Robert King

SELECT	  CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(HireDate, 'd', 'de-de') AS HireDate
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE EmployeeID = 7) -- AND EmployeeID != 7





