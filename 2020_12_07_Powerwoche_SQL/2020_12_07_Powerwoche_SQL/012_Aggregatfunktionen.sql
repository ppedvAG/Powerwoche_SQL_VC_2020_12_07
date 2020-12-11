-- Aggregatfunktionen (aggregate functions)


/*

	COUNT
	SUM
	AVG
	MIN
	MAX


*/

-- in welche Länder liefern wir denn?
SELECT DISTINCT Country
FROM Customers


-- in wie viele Länder liefern wir?
SELECT COUNT(Country)
FROM Customers
-- so viele, wie Customers (91)


SELECT COUNT(Region)
FROM Customers
-- hier gibt es NULL-Werte... daher nur so viele, wie Regions eingetragen sind (aber auch doppelte) -- 31


-- in wie viele Länder liefern wir:
SELECT COUNT(DISTINCT Country) AS Länderanzahl
FROM Customers
-- 21



-- wenn wir etwas zählen, wo es keine doppelten Einträge gibt (ID; wie viele Produkte, wie viele Customers,...), dann brauchen wir kein DISTINCT!

SELECT COUNT(ProductID) AS [Anzahl Produkte]
FROM Products
-- 77

-- kein DISTINCT machen: langsamer! (Muss ja noch überprüft werden!)
SELECT COUNT(DISTINCT ProductID)
FROM Products
-- 77


SELECT COUNT(*)
FROM Products
-- 77


-- Durchschnittswert berechnen: AVG (average)
SELECT AVG(UnitPrice) AS Durchschnittspreis
FROM Products
-- 28,8663



-- Summe bilden
SELECT SUM(Freight) AS [Summe aller Frachtkosten]
FROM Orders
-- 64942,69


-- kleinster/größter Wert
SELECT MIN(UnitPrice)
FROM Products

SELECT MAX(UnitPrice)
FROM Products



-- ******************************** GROUP BY ****************************************

-- SUMME PRO...?


-- Summe Frachtkosten PRO Kunde

SELECT	  SUM(Freight) AS [Summe Frachtkosten/Kunde]
		, CustomerID
FROM Orders
-- WHERE YEAR(ShippedDate) = 1996
GROUP BY CustomerID
ORDER BY [Summe Frachtkosten/Kunde]



SELECT SUM(Freight)
		, CustomerID
		, Freight
		, OrderID
FROM Orders
GROUP BY CustomerID, Freight, OrderID
-- bring nix!!! das sind wieder alle Bestellungen; Summe Frachtkosten pro Bestellung sind wieder genau die Frachtkosten!


-- das geht:
SELECT SUM(Freight)
		, ShipCountry
		, ShipCity
FROM Orders
GROUP BY ShipCountry, ShipCity
ORDER BY ShipCountry
-- Frachtkosten pro Stadt im jeweiligen Land


-- durchschnittliche Frachtkosten pro Frachtunternehmen?
SELECT AVG(Freight) AS [Frachtkosten/Frächter]
		, ShipVia
FROM Orders
GROUP BY ShipVia
ORDER BY ShipVia


-- durchschnittlicher Preis pro Anbieter?
SELECT AVG(UnitPrice)
		, SupplierID
FROM Products
GROUP BY SupplierID
ORDER BY SupplierID





