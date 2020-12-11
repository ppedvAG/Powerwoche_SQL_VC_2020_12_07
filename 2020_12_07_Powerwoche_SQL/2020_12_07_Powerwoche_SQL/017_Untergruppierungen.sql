-- Untergruppierungen

-- Mittelwert der Frachtkosten
SELECT AVG(Freight) AS [mittlere Frachtkosten]
FROM Orders
-- 78,2442


-- Mittelwert pro... z.B. Frachtunternehmen
SELECT    AVG(Freight) AS [mittlere Frachtkosten]
		, ShipVia
FROM Orders
GROUP BY ShipVia


-- mehrere Spalten mittlere Frachtkosten pro Kunde und Frächter
SELECT    AVG(Freight) AS [mittlere Frachtkosten]
		, ShipVia
		, CustomerID
FROM Orders
GROUP BY CustomerID, ShipVia
ORDER BY CustomerID, ShipVia


-- irgendwann macht es keinen Sinn mehr, weitere Spalten hinzuzufügen (z.B. wenn eindeutig)
SELECT    AVG(Freight) AS [mittlere Frachtkosten]
		, ShipVia
		, CustomerID
		, OrderID
FROM Orders
GROUP BY CustomerID, ShipVia, OrderID
-- kein Mittelwert mehr!
--ORDER BY CustomerID, ShipVia


-- pro Frachtunternehmen
SELECT    OrderID
		, ShipVia
		, CustomerID
		, AVG(Freight) 
				OVER(PARTITION BY ShipVia) AS [mittlere Frachtkosten]
FROM Orders

-- pro Kunde und Frächter
SELECT    OrderID
		, ShipVia
		, CustomerID
		, AVG(Freight) 
				OVER(PARTITION BY CustomerID, ShipVia) AS [mittlere Frachtkosten]
FROM Orders







