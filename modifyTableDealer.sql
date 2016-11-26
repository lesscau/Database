connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';
commit;

-- Cвязь комплектаций с опциями. Комплектация может включать некоторое количество опций
CREATE TABLE Comp_Option (
	id_comp_option INT PRIMARY KEY,
	id_comp INT REFERENCES Complectation(id_comp),
	id_op INT REFERENCES ExtraOption(id_op));
commit;

-- привязкa дополнительных опций к заказу, а не к автомобилю
ALTER TABLE OptionList ADD id_sale INT REFERENCES sale(id_sale);
ALTER TABLE OptionList DROP id_car;
commit;

-- связь многие ко многим между комплектациями, двигателями, трансмиссиями
CREATE TABLE Engine_Trans (
	id_engine_trans INT PRIMARY KEY,
	capacity VARCHAR(3) REFERENCES EngineCapacity(capacity),
	transType VARCHAR(2) REFERENCES Transmission(transType),
	enginePower INT REFERENCES EnginePower(enginePower));
commit;
ALTER TABLE Complectation ADD id_engine_trans INT REFERENCES Engine_Trans(id_engine_trans);
ALTER TABLE Complectation DROP capacity;
ALTER TABLE Complectation DROP enginePower;
ALTER TABLE Complectation DROP transType;
commit;

show tables;
SELECT * FROM EngineCapacity;
SELECT * FROM EnginePower;
SELECT * FROM Transmission;
SELECT * FROM Engine_Trans;
SELECT * FROM Comp_Option;
SELECT * FROM Complectation;