-- Transaction


BEGIN TRAN

UPDATE Helden
SET firstname = 'Minnie'
-- ups, Fehler passiert

ROLLBACK TRAN






BEGIN TRAN

UPDATE Helden
SET firstname = 'Minnie'
WHERE lastname = 'Mouse'

-- ROLLBACK TRAN

COMMIT TRAN

-- in dem Moment, wo wir ein Commit gemacht haben ist es fix und kann nicht mehr mit Rollback r�ckg�ngig gemacht werden




SELECT * FROM Helden


