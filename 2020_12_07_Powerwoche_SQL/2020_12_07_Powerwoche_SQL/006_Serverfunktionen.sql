-- Serverfunktionen

-- *************************** TRIM, LEN, DATALENGTH ******************************

SELECT 'Test'


SELECT 'Test     '


SELECT LEN('Test')

SELECT LEN('Test     ') -- 4 -- ignoriert Leerzeichen am Ende


SELECT LEN('     Test') -- 9 (Leerzeichen davor werden angezeigt)


SELECT LEN('     Test text') -- 14 (Leerzeichen in der Mitte werden auch angezeigt)


SELECT DATALENGTH('Test') -- 4

SELECT DATALENGTH('Test     ') -- 9 (z�hlt auch Leerzeichen am Ende mit)

SELECT DATALENGTH('  Test text    ') -- 15 (z�hlt die in der Mitte auch mit)
-- genaugenommen z�hlt DATALENGTH nicht Zeichen, sondern Speicherplatz


-- Achtung bei UNICODE: braucht doppelt so viel Speicherplatz; d.h. bei Datalength ist das Ergebnis doppelt so viel, wie Zeichen

SELECT DATALENGTH(Country), Country
FROM Customers
-- z.B. bei UK = 4

SELECT LEN(Country), Country
FROM Customers
-- bei UK = 2


SELECT RTRIM('Test       ') -- schneidet Leerzeichen auf der rechten Seite weg
SELECT LTRIM('     Test') -- schneidet Leerzeichen auf der linken Seite weg
SELECT TRIM('     Test     ') -- schneidet Leerzeichen links und rechts weg


SELECT DATALENGTH(TRIM('     Test     '))

SELECT LEN(TRIM(N'     Test     ')) -- trotz UNICODE: LEN z�hlt nur die Anzahl der Zeichen



-- ********************************* REVERSE **********************************

SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so hello Hose nie mit Gurt?')



-- ******************************* LEFT, RIGHT, SUBSTRING *************************
-- Zeichen ausschneiden

SELECT LEFT('Testtext', 4)  -- Test

SELECT RIGHT('Testtext', 4) -- text


SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- von der 4. Stelle ausgehend 2 ausschneiden



-- ************************************** STUFF **********************************
-- etwas einf�gen oder ersetzen

-- einf�gen
SELECT STUFF('Testtext', 5, 0, '_Hallo_') -- Test_Hallo_text
-- ausgehend von Stelle 5: 0 wegl�schen, _Hallo_ einf�gen

-- ersetzen
SELECT STUFF('Testtext', 4, 2, '_Hallo_') -- Tes_Hallo_ext
-- ausgehend von Stelle 4: 2 wegl�schen, _Hallo_ einf�gen



-- **************************** CONCAT ****************************************
-- zusammenf�gen

SELECT CONCAT('Test', 'text') -- Testtext

SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich wei�, ', 'dass ich', ' ', 'nichts wei�.') AS Zitat


SELECT CONCAT('James', ' ', 'Bond')

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees


SELECT CONCAT(FirstName, ' ', LastName) AS [Name Angestellte]
FROM Employees



/*
	Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden:
	z.B.:  +49 86779889xxx

	Bonus: die L�sung soll unabh�ngig von der L�nge der Telefonnummer funktionieren

*/


-- M�glichkeit 1:
SELECT STUFF('1234567890', 8, 3, 'xxx')
-- funktioniert nur mit fixer Anzahl an Zeichen

-- M�glichkeit 2:
SELECT STUFF('1234567890', LEN('1234567890')-2, 3, 'xxx')
-- funktioniert unabh�ngig von Anzahl der Zeichen


-- M�glichkeit 3:
SELECT LEFT('1234567890', 7) + 'xxx'
SELECT CONCAT(LEFT('1234567890', 7), 'xxx')
-- funktioniert nur mit fixer Anzahl an Zeichen

-- M�glichkeit 4:
SELECT CONCAT(LEFT('1234567890', LEN('1234567890')-3), 'xxx')
-- funktioniert unabh�ngig von Anzahl der Zeichen


-- M�glichkeit 5:

-- langsam:
SELECT REVERSE('1234567890') -- 0987654321

SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

-- wieder umdrehen:
SELECT REVERSE('xxx7654321') -- 1234567xxx



SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx')) -- 1234567xxx



-- mit DB-Abfrage:

SELECT STUFF(Phone, LEN(Phone)-2, 3, 'xxx'), Phone
FROM Customers


SELECT CONCAT(LEFT(Phone, LEN(Phone)-3), 'xxx'), Phone
FROM Customers


SELECT REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx')), Phone
FROM Customers


-- **************************** REPLICATE ****************************
-- Zeichen oder Zeichenfolgen mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('x', 3) -- xxx

SELECT REPLICATE('abc', 3) -- abcabcabc


-- ************************** Gro�-/Kleinschreibung bei Textausgabe *******************
SELECT UPPER('test')  -- TEST
SELECT LOWER('TEST') -- test


SELECT UPPER(firstName) AS firstName
FROM Employees


-- ********************************* REPLACE ********************************
-- bestimmte Zeichen ersetzen

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

-- mehrere Zeichen ersetzen (verschachteln)

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?


SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B') -- Bello?



-- ********************************* CHARINDEX **********************************
-- an welcher Stelle befindet sich ein bestimmtes Zeichen (oder Zeichenfolge)?
-- CHARINDEX zeigt das erste Vorkommen des gesuchten Zeichens
-- keine Mehrfachergebnisse, wenn gesuchtes Zeichen �fter vorkommt


SELECT CHARINDEX('a', 'Leo') -- 0 (wenn es nicht vorkommt)

SELECT CHARINDEX('e', 'Leo') -- 2

SELECT CHARINDEX(' ', 'James Bond') -- 6


SELECT ContactName
FROM Customers

-- auch nach Sonderzeichen suchen erlaubt
SELECT CHARINDEX('$', '450$')

SELECT CHARINDEX('%', '50%')

-- nach Zeichenfolgen suchen

SELECT CHARINDEX('schnecke', 'Zuckerschnecke')
-- an welcher Stelle beginnt die gesuchte Zeichenfolge




SELECT CHARINDEX(' ', ContactName), ContactName
FROM Customers


SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9


-- wie bekommen wir das letzte Leerzeichen?

-- zur Erinnerung: wie funktioniert SUBSTRING noch mal...?
-- so:
SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- von der 4. Stelle ausgehend 2 ausschneiden

-- langsam:
SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW


-- letztes Leerzeichen -> 1. Leerzeichen im umgedrehten Text
SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7

-- wieviele Zeichen sind es insgesamt
SELECT LEN('Wolfgang Amadeus Mozart') -- 23

-- 23 - 7 = 16

-- 23 - 7 + 1 = richtige Stelle

-- einsetzen in diese Werte:

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) +1 -- 17


SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9

SELECT LEN('Wolfgang Amadeus Mozart')


SELECT REVERSE('Wolfgang Amadeus Mozart')


-- 23 - 9 = 14

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'Wolfgang Amadeus Mozart')




-- SELECT RIGHT('Test', 2)
-- alles nach dem 1. Leerzeichen ausschneiden
-- SELECT RIGHT('Wolfgang Amadeus Mozart', (LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'Wolfgang Amadeus Mozart')))




-- 1234567890
-- nur letzte 3 Zeichen anzeigen
-- xxxxxxx890
-- dann unabh�ngig von L�nge
-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)


-- langsam:
SELECT STUFF('1234567890', 1, 7, 'xxxxxxx')

-- wie ging noch mal REPLICATE:
SELECT REPLICATE('?', 3) -- ???


-- REPLICATE einsetzen:
SELECT STUFF('1234567890', 1, 7, REPLICATE('x', 7))


-- wieviele Zeichen sind es insgesamt:
SELECT LEN('1234567890') -- 10

-- wie kommen wir auf 7?
SELECT LEN('1234567890') - 3


-- zusammenbauen:
-- �berall, wo 7 steht, Berechnung einsetzen:
SELECT STUFF('1234567890', 1, (LEN('1234567890') - 3), REPLICATE('x', (LEN('1234567890') - 3)))



-- DB:
SELECT STUFF(Phone, 1, (LEN(Phone) - 3), REPLICATE('x', (LEN(Phone) - 3))), Phone
FROM Customers



-- andere M�glichkeit mit RIGHT:

-- letzte 3 ausschneiden:
SELECT RIGHT('1234567890', 3)

SELECT RIGHT(Phone, 3)
FROM Customers

SELECT CONCAT('xxxxxxx', RIGHT(Phone, 3))
FROM Customers



SELECT CONCAT(REPLICATE('x', (LEN(Phone) - 3)), RIGHT(Phone, 3)), Phone
FROM Customers




