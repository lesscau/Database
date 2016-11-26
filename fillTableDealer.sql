connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';
commit;

-- Заполнение комплектаций

INSERT INTO ComplectationName VALUES ('active');
INSERT INTO ComplectationName VALUES ('supreme');
INSERT INTO ComplectationName VALUES ('exclusive');
INSERT INTO ComplectationName VALUES ('drive');
INSERT INTO ComplectationName VALUES ('comfort');
INSERT INTO ComplectationName VALUES ('gti');

INSERT INTO Carcase VALUES ('sedan');
INSERT INTO Carcase VALUES ('crossover');
INSERT INTO Carcase VALUES ('hatchback');
INSERT INTO Carcase VALUES ('picap');
INSERT INTO Carcase VALUES ('wagon');
INSERT INTO Carcase VALUES ('cabriolet');


INSERT INTO EngineCapacity VALUES (1.5);
INSERT INTO EngineCapacity VALUES (1.6);
INSERT INTO EngineCapacity VALUES (2.0);
INSERT INTO EngineCapacity VALUES (2.2);
INSERT INTO EngineCapacity VALUES (2.5);
INSERT INTO EngineCapacity VALUES (3.2);

INSERT INTO EnginePower VALUES (104);
INSERT INTO EnginePower VALUES (120);
INSERT INTO EnginePower VALUES (150);
INSERT INTO EnginePower VALUES (160);
INSERT INTO EnginePower VALUES (175);
INSERT INTO EnginePower VALUES (192);
INSERT INTO EnginePower VALUES (200);
INSERT INTO EnginePower VALUES (250);

INSERT INTO Transmission VALUES ('AT');
INSERT INTO Transmission VALUES ('MT');
INSERT INTO Transmission VALUES ('DT');

INSERT INTO ModelType VALUES ('Mazda3 sedan');
INSERT INTO ModelType VALUES ('Mazda3 hatchback');
INSERT INTO ModelType VALUES ('Mazda6 sedan');
INSERT INTO ModelType VALUES ('Mazda CX-5');
INSERT INTO ModelType VALUES ('Mazda CX-9');
INSERT INTO ModelType VALUES ('Mazda BT-50');
INSERT INTO ModelType VALUES ('Mazda MX-5');

INSERT INTO Complectation VALUES (1,'active','hatchback',1.5,120,'AT');
INSERT INTO Complectation VALUES (2,'active','sedan',1.6,104,'AT');
INSERT INTO Complectation VALUES (3,'comfort','sedan',1.5,120,'AT');
INSERT INTO Complectation VALUES (4,'drive','sedan',1.5,150,'AT');
INSERT INTO Complectation VALUES (5,'active','sedan',2.5,192,'AT');
INSERT INTO Complectation VALUES (6,'supreme','sedan',2.5,192,'AT');
INSERT INTO Complectation VALUES (7,'drive','crossover',2.0,150,'MT');
INSERT INTO Complectation VALUES (8,'supreme','crossover',2.5,192,'AT');
INSERT INTO Complectation VALUES (9,'active','crossover',2.2,175,'AT');
INSERT INTO Complectation VALUES (10,'supreme','picap',3.2,200,'MT');
INSERT INTO Complectation VALUES (11,'supreme','cabriolet',2.0,160,'MT');


INSERT INTO ModelComplectation VALUES (1,'Mazda3 hatchback',1,1259);
INSERT INTO ModelComplectation VALUES (2,'Mazda3 sedan',2,1249);
INSERT INTO ModelComplectation VALUES (3,'Mazda3 sedan',3,1344);
INSERT INTO ModelComplectation VALUES (4,'Mazda6 sedan',4,1304);
INSERT INTO ModelComplectation VALUES (5,'Mazda6 sedan',5,1355);
INSERT INTO ModelComplectation VALUES (6,'Mazda6 sedan',6,1576);
INSERT INTO ModelComplectation VALUES (7,'Mazda CX-5',7,1349);
INSERT INTO ModelComplectation VALUES (8,'Mazda CX-5',8,2012);
INSERT INTO ModelComplectation VALUES (9,'Mazda CX-9',9,2649);
INSERT INTO ModelComplectation VALUES (10,'Mazda BT-50',10,2345);
INSERT INTO ModelComplectation VALUES (11,'Mazda MX-5',11,2345);


INSERT INTO Car_available VALUES (1,1,'23456857445342341','white',1);
INSERT INTO Car_available VALUES (2,2,'73456853445342342','black',1);
INSERT INTO Car_available VALUES (3,3,'23456857445342343','white',0);
INSERT INTO Car_available VALUES (4,4,'63457857445342344','blue',0);
INSERT INTO Car_available VALUES (5,5,'23458857445342345','red',0);
INSERT INTO Car_available VALUES (6,6,'23456857445342346','red',0);
INSERT INTO Car_available VALUES (7,7,'53456857444342347','gray',0);
INSERT INTO Car_available VALUES (8,8,'23456857445342318','white',1);
INSERT INTO Car_available VALUES (9,9,'24456857445342349','black',1);
INSERT INTO Car_available VALUES (10,10,'13456857445342341','white',1);
INSERT INTO Car_available VALUES (11,11,'13456853445342341','red',1);

INSERT INTO Client VALUES (1,'Pavel Ivanov','01.12.1988','9112735684',1);
INSERT INTO Client VALUES (2,'Alex Kolpakov','08.04.1977','9112735684',1);
INSERT INTO Client VALUES (3,'Michael Pavlov','09.10.1989','9112735684',2);
INSERT INTO Client VALUES (4,'Roman Romanov','19.02.1984','9112735684',1);
INSERT INTO Client VALUES (5,'Maria Kalugina','11.12.1997','9112735684',1.3);

INSERT INTO Sale VALUES (1,'11.12.2014',1,5,1500,'11.12.2016');
INSERT INTO Sale VALUES (2,'11.12.2015',2,3,2000,'9.10.2012');
INSERT INTO Sale VALUES (3,'11.12.2016',3,4,6000,'19.02.2015');
INSERT INTO Sale VALUES (4,'8.09.2014',4,6,1500,'01.12.2016');
INSERT INTO Sale VALUES (5,'2.03.2015',5,7,1500,'10.06.2014');

INSERT INTO Warranty VALUES (1,2,'Sistema ohlazhdeniya','Otkaz ventilyatora','13.06.2016','15.07.2016');
INSERT INTO Warranty VALUES (2,4,'Zadnyaya vedushaya os','Iznoshen salnik vedushey shesterni','3.02.2015','15.07.2015');
INSERT INTO Warranty VALUES (3,5,'Podveska','Nizkoe davlenie gidronasosa','15.08.2014','18.08.2014');

INSERT INTO ExtraOption VALUES (1,'Winter set',5000);
INSERT INTO ExtraOption VALUES (2,'Fog lights',2000);
INSERT INTO ExtraOption VALUES (3,'Audiosystem',1500);
INSERT INTO ExtraOption VALUES (4,'Center armrest',500);
INSERT INTO ExtraOption VALUES (5,'Rear Parking Sensors',3000);
INSERT INTO ExtraOption VALUES (6,'Mazda Navigation System',5000);
INSERT INTO ExtraOption VALUES (7,'Remote Engine Start',7000);

INSERT INTO OptionList VALUES (1,1,2);
INSERT INTO OptionList VALUES (2,1,3);
INSERT INTO OptionList VALUES (3,4,4);
INSERT INTO OptionList VALUES (4,6,1);
INSERT INTO OptionList VALUES (5,8,2);
INSERT INTO OptionList VALUES (6,8,4);
INSERT INTO OptionList VALUES (7,10,7);
INSERT INTO OptionList VALUES (8,10,5);
INSERT INTO OptionList VALUES (9,9,3);
INSERT INTO OptionList VALUES (10,11,6);
INSERT INTO OptionList VALUES (11,11,7);

commit;
SELECT * FROM ComplectationName;
SELECT * FROM Carcase;
SELECT * FROM EngineCapacity;
SELECT * FROM EnginePower;
SELECT * FROM Transmission;
SELECT * FROM ModelType;
SELECT * FROM Complectation;
SELECT * FROM ModelComplectation;
SELECT * FROM Car_available;
SELECT * FROM Client;
SELECT * FROM Sale;
SELECT * FROM Warranty;
SELECT * FROM OptionList;
SELECT * FROM ExtraOption;
