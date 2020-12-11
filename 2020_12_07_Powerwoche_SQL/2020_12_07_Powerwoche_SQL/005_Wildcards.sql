-- Wildcards

/*
	
	% ......................... steht für beliebig viele unbekannte Zeichen (0 - ?)
	_ ......................... steht für GENAU EIN beliebiges unbekanntes Zeichen
    [] ........................ steht für GENAU EIN unbekanntes Zeichen aus einem bestimmten Wertebereich
	^ ......................... innerhalb der eckigen Klammern: NOT
	| ......................... (pipe) innerhalb der eckigen Klammern: OR




*/

USE Northwind

SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'


SELECT *
FROM Customers
WHERE  LEFT(CustomerID, 3) = 'ALF'

/*
	mögliche Treffer:

	ALF
	ALFslkdflskjdlsldkfjlskjdlfksjldkjfslkdjflksjdlkfjslkdjlksjdlkfjslkd
	ALFX

	ALFKI

*/


-- alle Länder, die mit A beginnen

SELECT *
FROM Customers
WHERE Country LIKE 'a%'


-- alle, die mit MI enden
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'



-- alle, die Zeichenfolge enthalten
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kiste%'


-- ***************************** genau 1 unbekanntes Zeichen suchen *****************

SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALFK_'


SELECT Phone
FROM Customers
WHERE Phone LIKE '(5) 555-472_'



-- *********************** Wertebereiche abfragen ***************************

-- [] als Wertebereich

-- alle Kunden, die mit a, b oder c beginnen

SELECT *
FROM Customers
WHERE CustomerID LIKE 'a%' OR CustomerID LIKE 'b%' OR CustomerID LIKE 'c%'


-- oder kürzer:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'


-- auch möglich:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[abc]%' -- oder


-- nur a oder c
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'


-- wie würden wir die bekommen, die mit abc beginnen?
SELECT *
FROM Customers
WHERE CustomerID LIKE 'abc%'



-- alle, die ein %-Zeichen oder Unterstrich im Namen haben
SELECT *
FROM Customers
WHERE CustomerID LIKE '%[%]%'


-- oder mit ESCAPE-Character:
SELECT *
FROM Customers
WHERE CustomerID LIKE '%!%%' ESCAPE '!'


-- alle mit Hochkomma im Namen?
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- Achtung, Trick: '', nicht ' (Ausnahme)



-- alle, die a beginnen und mit e enden?
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%e'


-- *********************** NOT ********************************
SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%'

-- auch hier gilt wieder: wenn möglich positiv formulieren:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-z]%'


-- endet mit d-z:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[d-z]'



-- alle, die mit a-c oder e-g enden?
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'


-- bisschen kürzer:

SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]'


-- alle Produkte, deren Name mit coffee endet?
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'



-- alle Produkte, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet?
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-d | m-o]'


-- oder bisschen kürzer:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'



SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')
-- ACHTUNG: einklammern! Sonst gewinnt AND vor OR



-- Gib alle Produkte aus, die vom Anbieter 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt:
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100


-- Annahme: falsche Einträge
-- ALF5I
-- AL$KI
-- wie finden wir die richtigen (5 Buchstaben), wie finden wir die falschen Einträge?

SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-z][a-z][a-z][a-z][a-z]'


SELECT *
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'



-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein L und der DRITTLETZTE Buchstabe ist ein d

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'


/*
	mögliche Treffer:

	edel
	edxl
	fidel
	ddxl
	dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxdxl

	Ernst Handel (in Northwind DB)
	e........e.l



*/
