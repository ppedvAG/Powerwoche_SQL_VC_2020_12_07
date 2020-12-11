-- DISTINCT


-- alle L�nder, in die wir liefern:

SELECT Country
FROM Customers
-- so viele, wie Kunden

SELECT DISTINCT Country
FROM Customers
ORDER BY Country



-- mehrere Spalten:
SELECT DISTINCT Country, CustomerID  -- bringt nix, weil jetzt wieder so viele, wie Kunden
FROM Customers
ORDER BY Country 


-- das w�re m�glich (und noch sinnvoll):
SELECT DISTINCT Country, City
FROM Customers
ORDER BY Country


