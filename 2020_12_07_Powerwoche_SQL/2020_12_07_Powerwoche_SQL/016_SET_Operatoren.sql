-- SET Operatoren

/*
			UNION  (macht DISTINCT)
			UNION ALL (gibt alle aus; UNION ALL ist auch schneller als UNION, da UNION erst überprüfen muss, ob es Mehrfacheinträge gibt)
			INTERSECT
			EXCEPT


*/



-- ************************** UNION, UNION ALL **********************************

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'



-- Achtung: geht nicht - muss gleiche Anzahl an Spalten haben!
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2'



-- Achtung: Fehlermeldung - gleiche bzw. kompatible bzw. implizit konvertierbare Datentypen müssen in einer Spalte stehen!
SELECT 'Testtext1', 'Testtext2'
UNION
SELECT 123, 'Testtext3'


-- Negativbeispiel:
-- CustomerID ist ein String-Datentyp (nchar(5) )
SELECT	  CustomerID
		, ContactName
FROM Customers
UNION
SELECT	  EmployeeID
		, LastName
FROM Employees


-- Problem wieder die CustomerID
SELECT	  CustomerID
		, ContactName
FROM Customers
UNION
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName)
FROM Employees



-- mit Datentyp umwandeln gehts:
SELECT	  CustomerID
		, ContactName
FROM Customers
UNION
SELECT	  CAST(EmployeeID AS nvarchar(50))
		, CONCAT(FirstName, ' ', LastName)
FROM Employees
-- EmployeeID in String-Datentyp umwandeln ist kein Problem, da wir damit keine Berechnungen anstellen wollen!




-- ALIAS vergeben erlaubt
SELECT	  CustomerID AS ID
		, ContactName
FROM Customers
UNION
SELECT	  CAST(EmployeeID AS nvarchar(50)) -- AS Hugo -- wird ignoriert, weil es schon eine Spaltenüberschrift gibt
		, CONCAT(FirstName, ' ', LastName)
FROM Employees

-- die erste Überschrift gewinnt - wird nicht überschrieben, weder von Alias noch von Original-Spaltennamen im zweiten Select



-- die Spalten müssen nicht gleich heißen
-- wir haben den Namen vom ersten SELECT als Spaltenüberschrift
-- wenn wir das nicht wollen --> ALIAS
SELECT	  Country
		, Phone -- AS Phone
FROM Customers
UNION
SELECT	  Country
		, HomePhone
FROM Employees



-- bei unterschiedlich vielen Spalten, dürfen wir auch selbst Text einfügen
-- dieser Text steht aber jetzt in jeder Zeile drin 
-- > von Fall zu Fall überlegen, ob das Sinn macht!
SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers
UNION
SELECT	  'Das sind ja wir!'
		, LastName
		, HomePhone
FROM Employees


-- wir dürfen auch NULL reinschreiben
-- > von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers
UNION
SELECT	  NULL
		, LastName
		, HomePhone
FROM Employees


-- Country, Region von Kunden und Angestellten
-- "das ist ein Kunde", "das ist ein Angestellter"

SELECT	  Country
		, Region
		, 'das ist ein Kunde' AS Category
FROM Customers
UNION
SELECT	  Country
		, Region
		, 'das ist ein Angestellter'
FROM Employees


-- deswegen "ABC"-Analyse
SELECT	  Country
		, Region
		, 'C' AS Category
FROM Customers
UNION
SELECT	  Country
		, Region
		, 'E'
FROM Employees


-- mit WHERE kombinieren erlaubt
SELECT	  Region
		, 'C' AS Category
FROM Customers
WHERE Region IS NOT NULL
UNION
SELECT	  Region
		, 'E'
FROM Employees
WHERE Region IS NOT NULL




-- UNION macht auch ein DISTINCT
SELECT 'Testtext'
UNION
SELECT 'Testtext'


-- wenn wir alles ausgegeben haben wollen, dann UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'



-- höchster/niedrigster Frachtkostenwert
SELECT	  MAX(Freight) AS Freight
		, 'höchster Frachtkostenwert'
FROM Orders
UNION ALL
SELECT	  MIN(Freight)
		, 'niedrigster Frachtkostenwert'
FROM Orders



-- mit OrderID

-- funktioniert nicht:
--SELECT	  OrderID
--		, MAX(Freight) AS Freight
--		, 'höchster Frachtkostenwert' AS Anmerkung
--FROM Orders
--GROUP BY OrderID
--UNION ALL
--SELECT	  OrderID
--		, MIN(Freight)
--		, 'niedrigster Frachtkostenwert'
--FROM Orders
--GROUP BY OrderID



-- mit TOP 

-- funktioniert NICHT:
--SELECT TOP 1 OrderID
--			, Freight
--			, 'niedrigster Wert' AS Anmerkung
--FROM Orders
--ORDER BY Freight
--UNION ALL
--SELECT TOP 1 OrderID
--			, Freight
--			, 'höchster Wert' AS Anmerkung
--FROM Orders
--ORDER BY Freight DESC



-- mit temporärer Tabelle gehts:

SELECT TOP 1 OrderID
			, Freight
			, 'niedrigster Wert' AS Anmerkung
INTO #niedrigster_Wert
FROM Orders
ORDER BY Freight



SELECT TOP 1 OrderID
			, Freight
			, 'höchster Wert' AS Anmerkung
INTO #hoechster_Wert
FROM Orders
ORDER BY Freight DESC
	

SELECT *
FROM #niedrigster_Wert
UNION ALL
SELECT *
FROM #hoechster_Wert



-- mit Subquery:
SELECT    OrderID
		, Freight
		, 'niedrigster Wert'
FROM Orders
WHERE Freight = (SELECT MIN(Freight) FROM Orders)
UNION ALL

SELECT    OrderID
		, Freight
		, 'höchster Wert'
FROM Orders
WHERE Freight = (SELECT MAX(Freight) FROM Orders)



SELECT *
FROM (
		SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
		FROM Orders
		ORDER BY Freight
	 ) AS N
UNION ALL
SELECT *
FROM (
		SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert
		FROM Orders
		ORDER BY Freight DESC
	 ) AS H










-- ********************************** INTERSECT, EXCEPT **************************************

CREATE TABLE #a (id int)

CREATE TABLE #b (id int)


INSERT INTO #a (id) VALUES (1), (NULL), (2), (1)

INSERT INTO #b (id) VALUES (1), (NULL), (3), (1)



-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3



-- UNION ALL
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1



-- INTERSECT
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1
-- INTERSECT zeigt mir Werte, die in Tabelle a UND in Tabelle b vorkommen (mit DISTINCT)



-- EXCEPT
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2
-- EXCEPT zeigt Unterschiede:
-- was gibt es in Tabelle a, was es in Tabelle b nicht gibt

-- alles in Tabelle b, was nicht in Tabelle a vorkommt:
-- einfach Reihenfolge umdrehen:
SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3


CREATE TABLE #c (id int)

CREATE TABLE #d (id int)

INSERT INTO #c (id) VALUES (1), (NULL), (2), (1)

INSERT INTO #d (id) VALUES (1), (NULL), (3), (1), (2), (2), (2)

-- in Tabelle d aber nicht in c
SELECT id
FROM #d
EXCEPT
SELECT id
FROM #c
-- 3

-- in Tabelle c aber nicht in d
SELECT id
FROM #c
EXCEPT
SELECT id
FROM #d
-- keine Ergebnisse (keine Unterschiede weil auch DISTINCT)




CREATE TABLE #e (id int)

CREATE TABLE #f (id int)

INSERT INTO #e (id) VALUES (1), (NULL), (2), (1)

INSERT INTO #f (id) VALUES (1), (NULL), (3), (1), (3), (3), (3)

-- in Tabelle e aber nicht in f
SELECT id
FROM #e
EXCEPT
SELECT id
FROM #f
-- 2

-- in Tabelle f aber nicht in e
SELECT id
FROM #f
EXCEPT
SELECT id
FROM #e
-- 3






-- *************************************** JOINS ************************************

SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1


SELECT a.id
FROM #a a LEFT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 2, 1, 1



SELECT a.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, NULL, 1, 1
-- WARUM??? Wo ist mein 3????



SELECT a.id, b.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- > aha, steht in der anderen Spalte

--> b.id auswählen
SELECT b.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 3, 1, 1



-- ***************************************************************************
-- ***************************************************************************
-- Testen


SELECT	  EmployeeID
		, LastName
		, FirstName
		, HomePhone
INTO #testEmp1
FROM Employees


SELECT	  EmployeeID
		, LastName
		, FirstName
		, HomePhone
INTO #testEmp2
FROM Employees


UPDATE #testEmp2
SET LastName = 'Bauer'
WHERE EmployeeID = 7


UPDATE #testEmp2
SET LastName = 'Bauer'
WHERE EmployeeID = 5



SELECT * FROM #testEmp2
EXCEPT
SELECT * FROM #testEmp1



--> wenn update, Bsp mit Vergleich von neuer und alter Tabelle







