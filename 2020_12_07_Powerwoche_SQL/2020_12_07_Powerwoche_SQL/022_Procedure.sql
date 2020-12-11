-- Procedures


CREATE PROC Demo100
AS
SELECT TOP 1 * FROM Orders ORDER BY Freight
SELECT TOP 1 * FROM Orders ORDER BY Freight DESC
SELECT Country FROM Customers WHERE Region IS NOT NULL
GO


EXEC Demo100



CREATE PROC p_Customers_Cities @City nvarchar(15)
AS
SELECT *
FROM Customers
WHERE City = @City
GO

-- drop proc p_Customers_Cities


EXEC p_Customers_Cities @City = 'Buenos Aires'




CREATE PROC p_Cust_Cit_Cou  @City nvarchar(15), @Country nvarchar(15)
AS
SELECT *
FROM Customers
WHERE City = @City AND Country = @Country
GO


EXEC p_Cust_Cit_Cou @City = 'Berlin', @Country = 'Germany'





ALTER PROCEDURE p_Customers_Cities @City nvarchar(15)
AS
SELECT * FROM Customers WHERE City LIKE @City
GO

EXEC p_Customers_Cities @City = '%'







-- **************************************** LOOP ******************************

DECLARE @i int
SET @i = 0
WHILE @i < 10
	BEGIN
		-- mein toller Code
		SET @i += 1
	END


