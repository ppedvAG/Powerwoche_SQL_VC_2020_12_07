-- VIEW WITH CHECK OPTION
USE Test

CREATE TABLE Helden (
						firstname varchar(30),
						lastname varchar(30),
						age int
					)


INSERT INTO Helden (firstname, lastname, age)
VALUES  ('James', 'Bond', 40),
		( 'Bruce', 'Wayne', 35),
		('Peter', 'Parker', 23)

SELECT *
FROM Helden

-- DROP TABLE Helden


CREATE VIEW v_Helden
AS
SELECT    firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL

-- DROP VIEW v_Helden





INSERT INTO Helden (firstname, lastname, age)
VALUES ('Obi Wan', 'Kenobi', NULL)



INSERT INTO v_Helden (firstname, lastname, age)
VALUES ('Pluto', 'Mouse', NULL)




SELECT * FROM Helden

SELECT * FROM v_Helden


DROP VIEW v_Helden


CREATE VIEW v_Helden
AS
SELECT    firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL
WITH CHECK OPTION



INSERT INTO v_Helden (firstname, lastname, age)
VALUES ('Mickey', 'Mouse', 42)



INSERT INTO v_Helden (firstname, lastname, age)
VALUES ('Minnie', 'Mouse', NULL)



INSERT INTO Helden (firstname, lastname, age)
VALUES ('Donald', 'Duck', NULL)

INSERT INTO Helden (firstname, lastname, age)
VALUES ('Saphira', NULL, NULL)



INSERT INTO v_Helden (firstname, lastname, age)
VALUES ('Fuchur', NULL, 456)



UPDATE v_Helden
SET age = NULL
WHERE firstname = 'James'



DELETE FROM v_Helden
WHERE firstname = 'James'


SELECT * FROM Helden

SELECT * FROM v_Helden






-- Pause:

--SELECT DATEADD(mi, 15, GETDATE()) -- 2020-12-10 15:24:12.067




