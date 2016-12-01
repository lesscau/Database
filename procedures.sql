SET TERM ^ ;
CREATE PROCEDURE insert_value ( n VARCHAR(10))
AS 
BEGIN
	INSERT INTO Carcase VALUES( :n );
END
^

CREATE PROCEDURE up_price(model VARCHAR(30))
AS BEGIN
	UPDATE ModelComplectation 
	SET price = price + 100 
	WHERE model = :model;
END
^

CREATE PROCEDURE rem_EnginePower(enginePower INT)
AS BEGIN
	DELETE FROM EnginePower 
	WHERE enginePower = 
		(select max(:enginePower) 
		from EnginePower);
END
^

CREATE PROCEDURE del_unused_Carcase
AS BEGIN
	DELETE FROM Carcase 
	WHERE carcaseType 
	NOT IN
		(SELECT carcaseType 
		FROM Complectation);
END
^

SET TERM ; ^