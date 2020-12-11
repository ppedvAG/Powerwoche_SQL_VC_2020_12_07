-- ER - Diagramme (Entity-Relationship)
-- Unterschiedliche Notationen (Chen, Min-Max, Krähenfuß (Crows-Foot),...)

-- Normalformen
-- 1. NF: "atomar" (1 Eintrag pro Feld)
-- 2. NF: 1. NF muss erfüllt sein UND alle müssen von 1 Schlüssel abhängig sein
-- 3. NF: 2. NF muss erfüllt sein UND es dürfen keine transitiven Abhängigkeiten bestehen (Nicht-Schlüsselfelder dürfen nicht voneinander abhängig sein)

-- NF: Idee: Redundanz vermeiden
-- Performance? Wir können NF auch brechen, wir müssen sie nicht zwingend einhalten.




/*
	
	Kunden:					1 Mio Kunde mit durchschnittlich 2 Bestellungen
	Bestellungen:			2 Mio Einträge mit durchschnittlich 2 Artikeln pro Bestellung
	Bestellpositionen:		4 Mio Bestell-Details (Menge*Preis)


	z.B. Menge*Preis ausrechnen für Rechnung mit Bestellsumme

	--> JOIN über alle Tabellen 
		7 Mio Datensätze, die abgearbeitet werden müssen für Auswertung


	--> Redundanz: Spalte Bestellsumme bei Bestellungen als zusätzliche Information
		3 Mio Datensätze, weil nicht in die Bestelldetails reingesehen werden muss

*/



-- Ergänzung zu INSERT, UPDATE, DELETE,...






-- 3 Varianten, wie wir PRIMARY KEY einfügen können:

-- Variante 1
CREATE TABLE Orders(
						 OrderID int identity PRIMARY KEY,  -- hier gleich dazuschreiben
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
						)


-- Variante 2:
CREATE TABLE Orders2(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
						CONSTRAINT PK_Orders2 PRIMARY KEY (OrderID) -- Constraint im Create
					)


-- Variante 3:

CREATE TABLE Orders3(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

ALTER TABLE Orders3
ADD CONSTRAINT PK_Orders3 PRIMARY KEY (OrderID) -- Constraint über ALTER TABLE hinzufügen



-- Foreign Keys:


-- Variante 1:
CREATE TABLE Orders4(
						 OrderID int identity,
						 CustomerID int FOREIGN KEY REFERENCES Customers4(CustomerID),
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

-- Das funktioniert nur dann, wenn es die Tabelle Customers4 und die Spalte CustomerID darin schon gibt!!!!


CREATE TABLE Customers4(
							CustomerID int identity PRIMARY KEY,
							CompanyName nvarchar(30),
--							...
--							...

						)


-- Variante 2:
CREATE TABLE Orders5(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
			CONSTRAINT FK_Orders2 FOREIGN KEY (CustomerID) REFERENCES Customers5(CustomerID)
					)


-- Variante 3:
CREATE TABLE Orders6(
						 OrderID int identity PRIMARY KEY,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

CREATE TABLE Customers6(
							CustomerID int IDENTITY PRIMARY KEY,
							CompanyName nvarchar(30),
--							...
--							...

						)

ALTER TABLE Orders6
ADD CONSTRAINT FK_Orders6_Customers6 FOREIGN KEY (CustomerID) REFERENCES Customers6(CustomerID)








