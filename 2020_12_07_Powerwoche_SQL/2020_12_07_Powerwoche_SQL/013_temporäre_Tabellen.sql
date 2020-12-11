-- temporäre Tabellen
-- temporary tables


/*
	lokale temporäre Tabellen
	exististieren nur in der aktuellen Session
	#tname




	globale temporäre Tabellen
	Zugriff auch aus anderen Sessions
	##tname


	-- beide: hält nur so lange, wie Verbindung da ist

	-- kann theoretisch auch gelöscht werden

*/



SELECT CustomerID, Freight
INTO #t1
FROM Orders




SELECT *
FROM #t1



SELECT OrderID, OrderDate
INTO ##test
FROM Orders