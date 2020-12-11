-- Datumsfunktionen

-- gängige Datentypen bei Datum
-- datetime (auf mehrere Millisekunden genau)
-- datetime2 (auf ~ 100 Nanosekunden genau)
-- date
-- time



/*
	
	-- Datumsintervalle:

	year, yyyy, yy ........................... Jahr
	quarter, qq, q ........................... Quartal
	month, MM, M ............................. Monat
	week, ww, wk ............................. Woche
	day, dd, d ............................... Tag
	hour, hh ................................. Stunde
	minute, mi, n ............................ Minute
	second, ss, s ............................ Sekunde
	millisecond, ms .......................... Millisekunde
	nanosecond, ns ........................... Nanosekunde

	weekday, dw, w ........................... Wochentag (dw = day of the week)
	dayofyear, dy, y ......................... Tag des Jahres


*/

SELECT HireDate
FROM Employees


-- *********************** Datum abfragen ***************************************

-- datetime (ms)
SELECT GETDATE()

-- datetime (ns)
SELECT SYSDATETIME()


-- ************************ DATEADD ******************************************
-- Datumsberechnungen: zum Datum etwas hinzu- oder wegrechnen

SELECT DATEADD(hh, 10, '2020-12-08')

SELECT DATEADD(hh, 10, '2020-12-08 13:56:23.123')

-- mit aktuellem Datum:
SELECT DATEADD(hh, 10, GETDATE())


-- mit negativem Vorzeichen:
SELECT DATEADD(hh, -10, GETDATE())


-- ************************* DATEDIFF *************************************
-- Differenz zwischen zwei Daten


SELECT DATEDIFF(dd, '2020-12-08', '2020-12-25') -- 17


SELECT DATEDIFF(dd, '2020-12-25', '2020-12-08') -- -17 (negatives Vorzeichen)

-- mit aktuellem Datum:
SELECT DATEDIFF(dd, GETDATE(), '2020-12-25')



-- ************************** DATEPART ***************************************
-- Rückgabedatentyp: int

SELECT DATEPART(dd, '2020-12-08')
SELECT DATEPART(dd, GETDATE())
SELECT DATEPART(MM, GETDATE())
SELECT DATEPART(yyyy, GETDATE())


-- ***************************** DATENAME ************************************
-- Datename macht eigentlich nur für zwei Datumsteile Sinn:
-- dw (Wochentag) und month (also die, wofür wir auch Text ausschreiben können)



SELECT DATENAME(dd, '2020-12-08') -- bringt nix, da kommt wieder 08 raus

SELECT DATENAME(dw, '2020-12-08') -- Tuesday
SELECT DATENAME(month, '2020-12-08') -- December


-- Welcher Wochentag war Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday


-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, '2020-12-08') -- 2021-01-15 00:00:00.000
SELECT DATEADD(dd, 38, GETDATE()) -- 2021-01-15 14:28:23.543
SELECT DATEADD(dd, 38, SYSDATETIME()) -- 2021-01-15 14:28:42.9390131



-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yyyy, '1977-05-25', '2020-12-08') -- 43
SELECT DATEDIFF(yy, '1977-05-25', '2020-12-08') -- 43
SELECT DATEDIFF(year, '1977-05-25', '2020-12-08') -- 43


SELECT DATEDIFF(yyyy, '1977-05-25', GETDATE()) -- 43


-- eigentlich brauchen wir nur das Jahr:
SELECT DATEDIFF(yyyy, '1977', GETDATE()) -- 43


--SELECT DATEDIFF(yyyy, '1977-05-25', '2020-05-27') -- 43
--SELECT DATEDIFF(yyyy, '1977-05-25', '2020-01-01') -- 43
-- berücksichtigt hier nur das Jahr!


-- Datum aufsplitten in drei Spalten
--   Tag     Monat     Jahr
--    8       12       2020



SELECT	  DATEPART(dd, GETDATE()) AS Tag
		, DATEPART(MM, GETDATE()) AS Monat
		, DATEPART(yyyy, GETDATE()) AS Jahr



SELECT	  BirthDate
		, DATEPART(dd, BirthDate) AS Tag
		, DATEPART(MM, BirthDate) AS Monat
		, DATEPART(yyyy, BirthDate) AS Jahr
FROM Employees


-- oder so:

SELECT	  BirthDate
		, DAY(BirthDate) AS Tag
		, MONTH(BirthDate) AS Monat
		, YEAR(BirthDate) AS Jahr
FROM Employees


-- Gib die Differenz zwischen Lieferdatum und Wunschtermin an:



-- Was ist die Lieferverzögerung: 
SELECT	  RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate)
FROM Orders


-- Wie viele Tage habe ich noch Zeit, um fristgerecht zu liefern?
SELECT	  RequiredDate
		, ShippedDate
		, DATEDIFF(dd, ShippedDate, RequiredDate)
FROM Orders



SELECT	  RequiredDate
		, ShippedDate
		, DATEDIFF(dd, ShippedDate, RequiredDate) AS [Tage übrig]
FROM Orders
ORDER BY [Tage übrig]


-- Pause:
SELECT DATEADD(mi, 15, GETDATE()) -- 2020-12-08 15:16:15.670



-- Bestellnummer, Wunschtermin, Lieferdatum, Lieferverzögerung
-- Ergebnisse von Bestellungen, die noch nicht geliefert wurden, sollen nicht ausgegeben werden
-- absteigend von der kleinsten zur größten Lieferverzögerung geordnet

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung -- ASC = ascending (default)

-- vom größten zum kleinsten Wert ordnen:

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung DESC -- descending = absteigend


-- Tag des Jahres

SELECT DATEPART(dy, GETDATE())

















