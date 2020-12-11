-- Having

-- Rechnungssumme?

SELECT	  od.OrderID
		, SUM(UnitPrice*Quantity-Discount)+Freight AS [Sum]
--		, Freight
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
--WHERE od.OrderID = 10979
GROUP BY od.OrderID, Freight
ORDER BY [Sum]



-- nur die Bestellungen, wo die Rechnungssumme größer als 500 ist
SELECT	  od.OrderID
		, SUM(UnitPrice*Quantity-Discount)+Freight AS [Sum]
--		, Freight
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY od.OrderID, Freight
HAVING SUM(UnitPrice*Quantity-Discount)+Freight > 500
ORDER BY [Sum]




-- Wieviele Kunden gibt es pro Land?
-- Nur die, wo mehr als 5 Kunden pro Land vorhanden sind
-- Anzahl, Country
-- meiste Kunden zuerst


SELECT	  Country
		, COUNT(CustomerID) AS [Anzahl Kunden]
FROM Customers
GROUP BY Country
HAVING Count(CustomerID) > 5
ORDER BY [Anzahl Kunden] DESC



-- alle Angestellten, die mehr als 70 Bestellungen bearbeitet haben
-- inklusive vollständiger Name, EmployeeID

SELECT	  e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
		, COUNT(OrderID) AS [Anzahl Bestellungen]
FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 70
ORDER BY [Anzahl Bestellungen] DESC


-- die Angestellten mit der Nummer 2 und 7, aber nur, wenn sie mehr als 50 Bestellungen bearbeitet haben

SELECT	  e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
		, COUNT(OrderID) AS [Anzahl Bestellungen]
FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE e.EmployeeID IN(2, 7)
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 50