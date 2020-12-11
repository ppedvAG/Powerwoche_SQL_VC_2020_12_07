-- Variablen

/*

		-- lokale Variablen
		-- @varname
		-- Zugriff nur in der Session, in der sie erstellt wurde



		-- globale Variablen
		-- @@varname
		-- Zugriff von außerhalb der Session


	-- Lebenszeit: nur solange der Batch läuft


	-- Variable deklarieren
	-- welchen Datentyp soll die Variable haben
	-- Wert zuweisen


	-- Syntax:

	DECLARE @varname AS Datentyp



*/


	-- Bsp.:

	DECLARE @var1 AS int

	-- Wert zuweisen:

	SET @var1 = 100


	SELECT @var1



	DECLARE @myDate datetime2 = SYSDATETIME()
	SELECT FORMAT(@myDate, 'd', 'de-de')



	DECLARE @freight AS money = 50


	SELECT *
	FROM Orders
	WHERE Freight > @freight


