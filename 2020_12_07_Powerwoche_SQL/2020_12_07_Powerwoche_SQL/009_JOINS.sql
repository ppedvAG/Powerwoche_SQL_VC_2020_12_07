-- JOIN

-- Informationen aus mehreren Tabellen abzufragen

-- INNER JOIN


				-- LEFT JOIN
-- OUTER JOIN
				-- RIGHT JOIN


SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID




SELECT	  Orders.CustomerID  -- wenn Name nicht eindeutig, MÜSSEN wir dazuschreiben, aus welcher Tabelle die Information kommen soll
		, CompanyName -- wenn Name nur in 1 Tabelle vorkommt, müssen wir es nicht dazuschreiben, aber wir SOLLTEN es dazuschreiben
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



SELECT	  Orders.CustomerID
		, Customers.CompanyName
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- kürzer schreiben mit ALIAS

SELECT	  o.CustomerID
		, c.CompanyName
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID



-- wir dürfen AS weglassen

SELECT	  o.CustomerID AS Kundennr
		, c.CompanyName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- alle Kontaktpersonen für die jeweiligen Bestellungen (wen rufe ich an, wenn etwas schiefgelaufen ist)

SELECT	  o.CustomerID AS Kundennr
		, c.CompanyName
		, c.ContactName
		, c.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID



/*
	Angenommen, es gab Beschwerden bei den Bestellungen 10251, 10280, 10990 und 11000.
	Welcher Angestellte hat diese Bestellungen bearbeitet?
	Vor- und Nachname in einem Feld als FullName ausgeben.

*/


SELECT	  o.OrderID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE OrderID IN(10251, 10280, 10990, 11000)


-- verjoinen von mehreren Tabellen

SELECT *
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON o.CustomerID = c.CustomerID



-- Welche Kunden haben Chai Tee gekauft und wieviel?
-- (OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT	  od.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
			     INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'



-- Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
-- Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.
-- Nach Menge und Kundenname geordnet:
--Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)


SELECT	  c.ContactName
--		, c.CustomerID
		, od.Quantity
		, p.ProductID
		, p.ProductName
FROM Orders o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
			  INNER JOIN Products p ON od.ProductID = p.ProductID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR p.ProductName LIKE '%ale'
ORDER BY od.Quantity DESC, c.CustomerID -- ASC





-- Vergleich INNER JOIN und OUTER JOINS


SELECT	  o.CustomerID AS Kundennr
		, c.CompanyName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
-- 830


SELECT	  o.CustomerID AS Kundennr
		, c.CompanyName
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
-- 830


SELECT	  o.CustomerID AS Kundennr
		, c.CompanyName
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID	
-- 832


SELECT	*
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID	


-- wie bekommen wir die Kunden, die noch nichts bestellt haben?
SELECT	  c.CustomerID AS Kundennr
		, c.CompanyName
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


-- SELECT *
-- FROM Customers CROSS JOIN Orders 





-- Wer ist der Chef von wem?
--Ausgabe:
--Name Angestellter, ID Angestellter, Name Chef, ID vom Chef

SELECT	  e.LastName
		, e.EmployeeID
		, m.LastName
		, m.EmployeeID
FROM Employees e LEFT JOIN Employees m ON m.EmployeeID = e.ReportsTo


-- ausfeilen
-- (mit INNER JOIN, wenn wir die, die keine Vorgesetzten haben, NICHT anzeigen wollen)
SELECT	  CONCAT(emp.FirstName, ' ', emp.LastName) AS EmpName
		, emp.EmployeeID AS EmpID
		, CONCAT(boss.FirstName, ' ', boss.LastName) AS BossName
		, boss.EmployeeID AS BossID
FROM Employees emp INNER JOIN Employees boss ON boss.EmployeeID = emp.ReportsTo
ORDER BY boss.EmployeeID


SELECT	  CONCAT(emp.FirstName, ' ', emp.LastName) AS EmpName
		, emp.EmployeeID AS EmpID
		, CONCAT(boss.FirstName, ' ', boss.LastName) AS BossName
		, boss.EmployeeID AS BossID
FROM Employees emp LEFT JOIN Employees boss ON boss.EmployeeID = emp.ReportsTo
ORDER BY boss.EmployeeID


SELECT	  CONCAT(emp.FirstName, ' ', emp.LastName) AS EmpName
		, emp.EmployeeID AS EmpID
		, CONCAT(boss.FirstName, ' ', boss.LastName) AS BossName
		, ISNULL(CAST(boss.EmployeeID AS varchar), 'Hat keinen Chef.') AS BossID
FROM Employees emp LEFT JOIN Employees boss ON boss.EmployeeID = emp.ReportsTo
ORDER BY boss.EmployeeID



/*
	Gib alle Kunden aus, die in der gleichen Stadt wohnen, wie ein anderer Kunde (nicht sie selbst).

	Ausgabe:
	Customer1, City1, Customer2, City2
	   
*/


SELECT	  c1.CustomerID
		, c2.CustomerID
		, c1.City
		, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY c1.City



