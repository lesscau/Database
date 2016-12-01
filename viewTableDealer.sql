--connect 'C:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';
connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';

commit;

drop view v1;
drop view v2;
drop view v3;
drop view v4;
drop view v5;
drop view v6;
drop view v7;
drop view v8;
drop view v9;
drop view v10;
drop view v11;
drop view v12;
drop view v13;
drop view v14;
drop view v15;
drop view v16;
drop view v17;
drop view v18;
drop view v19;
drop view v20;
drop view v21;
drop view v22;
drop view v23;
drop view v24;
drop view top10clients;
drop view top5engine;
drop view top5engine_id;
drop view year_options ;


CREATE VIEW v1 as SELECT * FROM ComplectationName;
CREATE VIEW v2 as SELECT * FROM Carcase;
CREATE VIEW v3 as SELECT * FROM EngineCapacity;
CREATE VIEW v4 as SELECT * FROM EnginePower;
CREATE VIEW v5 as SELECT * FROM Transmission;
CREATE VIEW v6 as SELECT * FROM Engine_Trans;
CREATE VIEW v7 as SELECT * FROM ModelType;
CREATE VIEW v8 as SELECT * FROM Complectation;
CREATE VIEW v9 as SELECT * FROM ModelComplectation;
CREATE VIEW v10 as SELECT * FROM Car_available;
CREATE VIEW v11 as SELECT * FROM Client;
CREATE VIEW v12 as SELECT * FROM Sale;
CREATE VIEW v13 as SELECT * FROM Warranty;
CREATE VIEW v14 as SELECT * FROM OptionList;
CREATE VIEW v15 as SELECT * FROM Comp_Option;
CREATE VIEW v16 as SELECT * FROM ExtraOption;

CREATE VIEW v17 
	as SELECT model,price 
	FROM ModelComplectation
	WHERE model in ('Mazda3 sedan', 'Mazda3 hatchback')
	AND price BETWEEN 1500 AND 5000;
--select * from v17;


CREATE VIEW v18 
	as SELECT name,phone
	FROM Client
	WHERE name like 'M%'
	OR name like 'A%';
--select * from v18;


	SELECT SUM(totalPrice) 
	FROM sale
	WHERE dat BETWEEN '01.01.2015' AND '31.12.2015';

CREATE VIEW v19  AS
	SELECT compName, carcaseType FROM Complectation ORDER BY carcaseType,compName;
--	select * from v19;	
	
CREATE VIEW v20  AS
	SELECT MIN(price) as minimum, AVG(price) as average, MAX(price) as maximum
	FROM ModelComplectation;
--select * from v20;		
	
	
CREATE VIEW v21 AS 
	SELECT ModelComplectation.model, ModelComplectation.price, Car_available.vin
	FROM ModelComplectation,Complectation,Car_available,Engine_Trans
	WHERE ModelComplectation.price > 2000
	AND Engine_Trans.transType = 'DT'
	AND Engine_Trans.capacity = 3.2
	AND ModelComplectation.id_comp = Complectation.id_comp
	AND Car_available.id_mc = ModelComplectation.id_mc
	AND Engine_Trans.id_engine_trans = Complectation.id_engine_trans;
--select * from v21;	

	
CREATE VIEW v22 AS 
	SELECT DISTINCT Client.name, sale.totalPrice, Warranty.problem, sale.dat
	FROM Client,sale,Warranty
	WHERE sale.dat  BETWEEN '20.11.2016' AND '30.11.2016'
	AND sale.id_client = Client.id_client
	AND Warranty.id_sale = sale.id_sale;
--select * from v22;

CREATE VIEW v23(color, numb) AS
	SELECT model, MIN(price) 
	FROM ModelComplectation GROUP BY model HAVING MIN(price) >1100;
--select * from v23;

CREATE VIEW v24 AS
	SELECT compName
	FROM Complectation
	WHERE Complectation.id_comp IN
		(SELECT	id_comp 
		FROM ModelComplectation
		WHERE model = 'Mazda3 sedan');
--select * from v24;


--	Вывести количество заказанных дополнительных опций по месяцам заданного года
CREATE VIEW year_options AS
	SELECT 	EXTRACT(Year FROM dat) AS Y, 
			EXTRACT(Month FROM dat) AS M,
			COUNT(2) AS ordered_options
	FROM sale
	JOIN optionlist USING (id_sale)
	WHERE dat BETWEEN '01.01.2015' AND '31.12.2015'
	GROUP BY 1,2;
select * from year_options;

--	Вывести 5 наиболее популярных двигателей за заданный период
CREATE VIEW top5engine_id AS
	SELECT first 5 	id_engine_trans as id_engine, count(id_engine_trans) as count_engines 
	from Engine_Trans
	join complectation using (id_engine_trans)
	join modelcomplectation using (id_comp)
	join car_available using (id_mc)
	join sale using (id_car)
	GROUP BY id_engine_trans 
	ORDER BY count_engines DESC;
--select * from top5engine_id;

CREATE VIEW top5engine AS
	SELECT id_engine, capacity,transType,enginePower,  count_engines
	FROM top5engine_id, Engine_Trans
	WHERE top5engine_id.id_engine = Engine_Trans.id_engine_trans;
--select * from top5engine;

--	Вывести 10 клиентов, которые совершили повторный заказ на большую сумму
CREATE VIEW top10clients AS
	SELECT FIRST 10 name, totalPrice
	FROM client,sale 
	WHERE sale.id_client IN
		(SELECT sale.id_client 
		FROM sale
		GROUP BY sale.id_client 
		HAVING COUNT(sale.id_client) > 1)
	AND sale.id_client = client.id_client
	ORDER BY totalPrice DESC;
--select * from top10clients;

commit;

