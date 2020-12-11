-- tempor�re Tabellen
-- temporary tables


/*
	lokale tempor�re Tabellen
	exististieren nur in der aktuellen Session
	#tname




	globale tempor�re Tabellen
	Zugriff auch aus anderen Sessions
	##tname


	-- beide: h�lt nur so lange, wie Verbindung da ist

	-- kann theoretisch auch gel�scht werden

*/



SELECT CustomerID, Freight
INTO #t1
FROM Orders




SELECT *
FROM #t1



SELECT OrderID, OrderDate
INTO ##test
FROM Orders