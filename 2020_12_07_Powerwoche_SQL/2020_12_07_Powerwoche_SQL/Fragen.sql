SELECT 'true' 
WHERE 3 IN (1, 2, 3, NULL)


SELECT 'true' 
WHERE 3 NOT IN (1, 2, NULL)

-- entspricht:
SELECT 'true'
WHERE 3 != 1 AND 3 != 2 AND 3 != NULL
-- wir dürfen aber keine mathematischen Operatoren bei NULL verwenden


-- so gehts:
SELECT 'true'
WHERE 3 != 1 AND 3 != 2 AND 3 IS NOT NULL

-- SET ANSI_NULLS OFF | ON (Default)