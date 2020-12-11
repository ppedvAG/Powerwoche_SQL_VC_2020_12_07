-- TOP
-- ORDER BY zwingend notwendig, damit die Daten in der von uns vorgesehenen Reihenfolge ausgegeben werden
-- was ist die erste Zeile? Abh�ngig von ORDER BY.





-- erste Zeile
SELECT TOP 1 *
FROM Customers
-- ALFKI

SELECT TOP 1 *
FROM Customers
WHERE Country = 'Argentina'
-- CACTU

SELECT TOP 1 *
FROM Customers
WHERE Country = 'Argentina'
ORDER BY City
-- OCEAN


SELECT TOP 1	  CustomerID
				, CompanyName
				, ContactName
		--		, ....
FROM Customers
WHERE Country = 'Argentina'
ORDER BY City  -- wir d�rfen auch nach Spalten ordnen, die im SELECT nicht vorkommen - von Fall zu Fall entscheiden: macht das Sinn?



SELECT TOP 1	  CustomerID
				, CompanyName
				, ContactName
		--		, ....
FROM Customers
WHERE Region IS NOT NULL
ORDER BY City
-- RATTC


-- funktioniert auch mit Prozent ... PERCENT ausschreiben, % funktioniert nicht

SELECT TOP 10 PERCENT	  CustomerID
						, CompanyName
						, ContactName
				--		, ....
FROM Customers
ORDER BY City

-- 10% aufgerundet auf den n�chsten Integerwert!


-- wie bekomme ich die letzten 5 Eintr�ge?
SELECT TOP 5			  CustomerID
						, CompanyName
						, ContactName
				--		, ....
FROM Customers
ORDER BY City DESC



-- mit ausgeben, wenn einer noch den gleichen Wert hat, wie der letzte, der von dem SELECT erfasst wird


-- wenn jemand auf Platz 18 den gleichen Wert hat, wie der auf Platz 17, wird er auch mit ausgegeben:
SELECT TOP 17 WITH TIES	  Freight
						, OrderID
			--			, ...
FROM Orders
ORDER BY Freight




-- Suche die Top 10% der Produkte mit den gr��ten Verkaufsmengen (ProductName, Quantity).
-- Einschlie�lich Produkte mit der gleichen Einkaufsmenge wie das letzte in der urspr�nglichen Ausgabe.
SELECT TOP 10 PERCENT WITH TIES	  p.ProductID
								, p.ProductName
								, od.Quantity
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY od.Quantity DESC




-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am l�ngsten beim Unternehmen sind).
-- W�hle nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.
SELECT TOP 3	  FirstName
				, LastName
				, HireDate
FROM Employees
ORDER BY HireDate


SELECT TOP 3	  CONCAT(FirstName, ' ', LastName) AS EmpName
				, FORMAT(HireDate, 'd', 'de-de') AS HireDate
FROM Employees
ORDER BY HireDate




