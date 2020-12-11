-- CAST, CONVERT, FORMAT
-- in welchem Datentyp wollen wir etwas ausgeben
-- in welchem Format


-- ************************* Datentypen *************************************
/*
	-- String Datentypen

		char(n) - fixe Anzahl an Zeichen
		varchar(n) - variable Anzahl an Zeichen
		nchar(n) - fixe Anzahl an Zeichen (in UNICODE!)
		nvarchar(n) - variable Anzahl an Zeichen (in UNICODE!)


	-- numerische Datentypen
		
		bit - 1, 0, NULL

		int - ganze Zahlen
			
			tinyint, smallint, bigint

		float - Zahlen mit Kommastellen
		decimal(10, 2) - insgesamt 10 Stellen, davon 8 vor dem Komma, 2 nach dem Komma

		money - auf 4 Nachkommastellen genau


	-- Datumsdatentypen

		datetime - auf 3-4 ms genau
		datetime2 - auf ~100 ns genau
		date - nur Datum
		time - nur Zeit


	-- boolean, bool - true | false


*/







	--SELECT Country, DATALENGTH(Country), LEN(Country)
	--FROM Customers

	--SELECT CustomerID, DATALENGTH(CustomerID)
	--FROM Customers

	--SELECT ProductName
	--FROM Products



-- ******************************* CAST ************************************
-- Umwandeln von Datentypen


SELECT '123' + 3  -- 126


SELECT '123.5' + 3
-- Conversion failed when converting the varchar value '123.5' to data type int.



SELECT CAST('123.5' AS float) + 3 -- 126,5


SELECT CAST('123.5' AS decimal(10,2)) -- 123.50


/*
	-- implizite und explizite Konvertierung in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/



-- auch Datums-Datentypen können wir in einen anderen Datentyp umwandeln, aber mit CAST allein haben wir keinen Einfluss auf das Datumsformat


SELECT CAST(SYSDATETIME() AS varchar)

SELECT CAST(GETDATE() AS varchar)


-- VORSICHT mit Anzahl an Zeichen! Geht sich das, was wir anzeigen wollen, darin noch aus??

SELECT CAST(SYSDATETIME() AS varchar(3)) -- Blödsinn!

SELECT CAST(SYSDATETIME() AS varchar(10)) -- Blödsinn!

SELECT CAST(GETDATE() AS varchar(10)) -- Blödsinn!



SELECT CAST('2020-12-09' AS date) -- 2020-12-09
-- ACHTUNG: was ist Tag, was ist Monat? Serverabhängig!


-- mit DB:
SELECT HireDate
FROM Employees
-- 1992-05-01 00:00:00.000

SELECT CAST(HireDate AS varchar)
FROM Employees
-- May  1 1992 12:00AM




-- **************************** CONVERT ****************************************
-- auch mit CONVERT haben wir (wie der Name schon sagt) die Möglichkeit, einen Datentyp in einen anderen zu konvertieren, aber hier haben wir auch eine Style-Option
-- Style-Parameter (optional)

-- Syntax:
/*

	SELECT CONVERT(data_type[(length)], expression[, style])

	-- zuerst: in welchen Datentyp soll konvertiert werden
	-- WAS soll konvertiert werden
	-- optional: Style-Parameter (in welchem Format soll das Datum ausgegeben werden)


*/


SELECT CONVERT(float, '123.5') + 3 -- 126,5


SELECT CONVERT(varchar, SYSDATETIME()) -- 2020-12-09 09:52:55.2530550

-- wieder Achtung mit Anzahl!
SELECT CONVERT(varchar(3), SYSDATETIME()) -- 202


SELECT CONVERT(varchar, SYSDATETIME(), 104) -- 09.12.2020



SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB


/*
	Date- und Time-Styles in der Microsoft-Dokumentation:
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/


SELECT	  CONVERT(varchar, HireDate, 104) AS DE
		, CONVERT(varchar, HireDate, 101) AS US
		, CONVERT(varchar, HireDate, 103) AS GB
FROM Employees




-- ******************************* FORMAT ***************************************
-- Ausgabedatentyp ist nvarchar


SELECT FORMAT(1234567890, '###-###/## ##') -- 123-456/78 90

-- Vorsicht, wenn weniger Zeichen:
SELECT FORMAT(1234567, '###-###/## ##') --    -123/45 67


SELECT FORMAT(431234567890, '+' + '##/### ## ## ###') -- +43/123 45 67 890


-- auch mit Datum relativ frei:

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- 09.12.2020
-- wieder Achtung! MM großschreiben!

SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- 09.06.2020 (mm klein wird fälschlicherweise als Minute interpretiert!)


SELECT FORMAT(GETDATE(), 'd.M.yy') -- 9.12.20


SELECT FORMAT('2020-12-09', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.


-- mit DB:
SELECT FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees



SELECT FORMAT(HireDate, 'dd.MM.yyyy hh:mm') -- 01.05.1992 12:00
FROM Employees


-- mit Culture-Parameter:

SELECT FORMAT(GETDATE(), 'd', 'de-de') AS DE -- 09.12.2020
-- klein d: Datum in Zahlen

SELECT FORMAT(GETDATE(), 'D', 'de-de') AS DE -- Mittwoch, 9. Dezember 2020
-- groß D: Datum ausgeschrieben (wenn möglich)


/*
	Microsoft-Dokumentation Supported Culture-Codes:

	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes

*/


SELECT	  FORMAT(GETDATE(), 'd', 'de-de') AS DE
		, FORMAT(GETDATE(), 'd', 'en-us') AS US
		, FORMAT(GETDATE(), 'd', 'en-gb') AS GB
		, FORMAT(GETDATE(), 'd', 'sv') AS SV



SELECT	  FORMAT(GETDATE(), 'D', 'de-de') AS DE
		, FORMAT(GETDATE(), 'D', 'en-us') AS US
		, FORMAT(GETDATE(), 'D', 'en-gb') AS GB
		, FORMAT(GETDATE(), 'D', 'sv') AS SV



-- Gib die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.

SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS [Name]
		, TitleOfCourtesy 
		, FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
		, HomePhone
FROM Employees



SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS [Name]
		, TitleOfCourtesy 
		, FORMAT(BirthDate, 'd', 'de-de') AS BirthDate -- mit Culture-Parameter
		, HomePhone
FROM Employees


SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS [Name]
		, TitleOfCourtesy 
		, CONVERT(varchar, BirthDate, 104) AS BirthDate -- mit Style-Parameter
		, HomePhone
FROM Employees



