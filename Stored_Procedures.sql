connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';


SET TERM ^ ;

CREATE or alter PROCEDURE copy_comp 
	( id INT, name VARCHAR(30))
AS 
	declare variable carcaseType VARCHAR(10);
	declare variable id_engine_trans INT ;
BEGIN
	select carcaseType, id_engine_trans
		from Complectation
		where id_comp = :id
		into :carcaseType, :id_engine_trans;
	
	insert into Complectation (id_comp, compName, carcaseType, id_engine_trans)
		select max(Complectation.id_comp)+1, :name, :carcaseType, :id_engine_trans
		from Complectation;
END
^


------------------------------------------------


-- search all complectations with same options
CREATE or alter PROCEDURE find_all_complect (id_sale INT)
RETURNS (id_comp int, cnt int)
AS
declare variable sale_comp int;
declare variable delta int;
BEGIN
	select id_comp 
	from modelcomplectation
	join car_available using (id_mc)
	join sale using (id_car)
	where id_sale = :id_sale
	into :sale_comp;
	for 
		select id_comp, count(id_comp) as cnt from 
		(
			select cop2.id_comp 
			FROM comp_option as cop1, comp_option as cop2
			where cop1.id_op = cop2.id_op
			and cop1.id_comp <> cop2.id_comp
			and cop1.id_comp = :sale_comp
			union all
			
			select cop.id_comp 
			FROM optionlist as op, comp_option as cop
			where op.id_op = cop.id_op
			and op.id_sale = :id_sale
			and op.id_op not in 
				(select id_op from comp_option where id_comp = :sale_comp)
		)	
		group by id_comp
		order by cnt desc
		into :id_comp, :cnt
	do begin
		suspend;
	end
end^
	
-- search complectations where count of the same options take more then 50%
CREATE or alter PROCEDURE find_optimal_complect (id_sale INT)
RETURNS (id_comp int, cnt int)
AS
declare variable maxcnt int;
BEGIN

	select max(cnt) as maxcnt 
	from find_all_complect (:id_sale)
	into :maxcnt; 
	
	maxcnt = :maxcnt/2;
	
	for 
		select id_comp,cnt
		from find_all_complect (:id_sale)
		where cnt > :maxcnt
		into :id_comp,:cnt
	do begin
		suspend;
	end
	
END^
	
-- search models with found complectations 
-- search the difference in price 	
CREATE or alter PROCEDURE find_all_models (id_sale INT)
RETURNS (id_mc int, delta int)
AS
declare variable newprice int;
declare variable oldprice int;
declare variable model varchar(30);
BEGIN

-- find equal model ( not used due to insufficient data )
/*  
	select model
	from modelcomplectation
	join car_available using (id_mc)
	join sale using (id_car)
	where id_sale = :id_sale
	into :model;
*/

	select totalprice from sale where id_sale = :id_sale
	into :oldprice; 
	for  
		select id_mc, price from modelcomplectation
		where id_comp in
		(
			select id_comp from find_optimal_complect (:id_sale)
		)
		--and model = :model
		order by :delta 
		into :id_mc, :newprice
	do begin
		delta = abs(:oldprice - :newprice);
		suspend;
	end
end ^

-- output found configuration 
CREATE or alter PROCEDURE find_equal (id_sale INT)
RETURNS (old_id int, old_model varchar (15), old_comp varchar(15), old_price int, 
		new_id int, find_model varchar (15), find_comp varchar(15), new_price int )
AS
	declare variable mc int;
	declare variable id_comp int;
	declare variable min_delta INT ;
BEGIN
	select id_comp, compname, model, totalprice
	from complectation
	join modelcomplectation using (id_comp)
	join car_available using (id_mc)
	join sale using (id_car)
	where id_sale = :id_sale
	into :old_id, :old_comp, :old_model, :old_price;

	select first 1 id_mc, delta
	from find_all_models (:id_sale)
	order by delta
	into :mc, :min_delta;
		
	select id_comp, compname, model, price from complectation
	join modelcomplectation using (id_comp)
	where id_mc = :mc
	into :new_id,:find_comp, :find_model, :new_price;
	suspend;
	
END
^
CREATE or alter PROCEDURE old_options (id_sale INT)
RETURNS (old_options varchar (30))
		
AS
BEGIN
	for 
		select optiontype
		from extraoption
		join optionlist using (id_op)
		where id_sale = :id_sale
		
		union
		
		select optiontype
		from extraoption
		join comp_option using (id_op)
		join complectation using (id_comp)
		join modelcomplectation using (id_comp)
		join car_available using (id_mc)
		join sale using (id_car)
		where id_sale = :id_sale
		into :old_options
	do begin
		suspend;
	end
END ^

CREATE or alter PROCEDURE new_options (id_comp INT)
RETURNS (new_options varchar (30))
		
AS
BEGIN
	for 
		select optiontype
		from extraoption
		join comp_option using (id_op)
		where id_comp = :id_comp
		into :new_options
	do begin
		suspend;
	end
END ^

SET TERM ; ^