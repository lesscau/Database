create database 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';
commit;
connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';
commit;
CREATE TABLE Complectation (
	id_comp INT PRIMARY KEY,
	compName VARCHAR(30),
	carcaseType VARCHAR(10),
	capacity FLOAT,
	enginePower INT,
	transType VARCHAR(2));
commit;
CREATE TABLE Car_available (
	id_car INT PRIMARY KEY,
	id_mc INT  UNIQUE,
	vin VARCHAR(17)  UNIQUE,
	color VARCHAR(20),
	available SMALLINT);
CREATE TABLE Client (
	id_client INT PRIMARY KEY,
	name VARCHAR(50),
	dat DATE,
	phone VARCHAR(10),
	bonus INT);
CREATE TABLE sale ( 
	id_sale INT PRIMARY KEY,
	dat DATE,
	id_client INT,
	id_car INT,
	totalPrice FLOAT,
	warrantyPeriod DATE);
CREATE TABLE Warranty (
	id_warr INT PRIMARY KEY,
	id_sale INT,
	defect VARCHAR(30),
	problem VARCHAR(30),
	dateRequest DATE,
	dateExec DATE );

CREATE TABLE Transmission (
	transType VARCHAR(2) PRIMARY KEY
);

CREATE TABLE Carcase (
	carcaseType VARCHAR(10) PRIMARY KEY
);

CREATE TABLE EnginePower (
	enginePower INT PRIMARY KEY
);

CREATE TABLE EngineCapacity (
	capacity VARCHAR(3) PRIMARY KEY
);

CREATE TABLE ComplectationName (
	compName VARCHAR(30) PRIMARY KEY
);

CREATE TABLE ModelComplectation (
	id_mc INT PRIMARY KEY,
	model VARCHAR(30),
	id_comp INT,
	price FLOAT 
);

CREATE TABLE ModelType (
	model VARCHAR(30) PRIMARY KEY
);

CREATE TABLE OptionList (
	id_oplist INT PRIMARY KEY,
	id_car INT,
	id_op INT
);

CREATE TABLE ExtraOption (
	id_op INT PRIMARY KEY,
	optionType VARCHAR(50) UNIQUE,
	optionPrice FLOAT 
);
commit;
 

ALTER TABLE Complectation ADD CONSTRAINT Complectation_fk0 FOREIGN KEY (compName) REFERENCES ComplectationName(compName);

ALTER TABLE Complectation ADD CONSTRAINT Complectation_fk1 FOREIGN KEY (carcaseType) REFERENCES Carcase(carcaseType);

ALTER TABLE Complectation ADD CONSTRAINT Complectation_fk2 FOREIGN KEY (capacity) REFERENCES EngineCapacity(capacity);

ALTER TABLE Complectation ADD CONSTRAINT Complectation_fk3 FOREIGN KEY (enginePower) REFERENCES EnginePower(enginePower);

ALTER TABLE Complectation ADD CONSTRAINT Complectation_fk4 FOREIGN KEY (transType) REFERENCES Transmission(transType);

ALTER TABLE Car_available ADD CONSTRAINT Car_available_fk0 FOREIGN KEY (id_mc) REFERENCES ModelComplectation(id_mc);

ALTER TABLE sale ADD CONSTRAINT sale_fk0 FOREIGN KEY (id_client) REFERENCES Client(id_client);

ALTER TABLE sale ADD CONSTRAINT sale_fk1 FOREIGN KEY (id_car) REFERENCES Car_available(id_car);

ALTER TABLE Warranty ADD CONSTRAINT Warranty_fk0 FOREIGN KEY (id_sale) REFERENCES sale(id_sale);

ALTER TABLE ModelComplectation ADD CONSTRAINT ModelComplectation_fk0 FOREIGN KEY (model) REFERENCES ModelType(model);

ALTER TABLE ModelComplectation ADD CONSTRAINT ModelComplectation_fk1 FOREIGN KEY (id_comp) REFERENCES Complectation(id_comp);

ALTER TABLE OptionList ADD CONSTRAINT OptionList_fk0 FOREIGN KEY (id_car) REFERENCES Car_available(id_car);

ALTER TABLE OptionList ADD CONSTRAINT OptionList_fk1 FOREIGN KEY (id_op) REFERENCES ExtraOption(id_op);

show tables;

