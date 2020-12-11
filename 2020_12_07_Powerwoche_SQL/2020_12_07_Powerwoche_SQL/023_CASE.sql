-- CASE


SELECT	  OrderID
		, Quantity
		, CASE
			WHEN Quantity > 10 THEN 'größer 10'
			WHEN Quantity < 10 THEN 'kleiner 10'

			ELSE 'unbekannt'
		  END
FROM [Order Details]




-- wenn EU Mitglied, dann 'EU'
-- nicht EU, dann 'nicht EU'
-- wenn unbekannt, dann 'unbekannt'

SELECT	    CustomerID
		  , CompanyName
		  , Country
		  , CASE
				WHEN Country IN('Germany', 'Austria', 'France') THEN 'EU'
				WHEN Country IN('Argentina', 'US', 'Brazil') THEN 'nicht EU'
				WHEN Country = 'UK' THEN 'Brexit'

				ELSE 'keine Ahnung'
			END AS [Zugehörigkeit]
FROM Customers
ORDER BY Zugehörigkeit






