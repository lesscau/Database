--connect 'D:\Univer\DataBase\dealership.fdb' user 'SYSDBA' password 'masterkey';

drop TRIGGER auto_gen;
drop generator increment;
drop TRIGGER check_stage;
drop EXCEPTION ERROR_STAGE;
drop TRIGGER add_op;
drop EXCEPTION OPTALREADY;
SET TERM ^ ;

---------------------------------

CREATE  generator increment^
CREATE OR ALTER TRIGGER auto_gen FOR ExtraOption BEFORE INSERT
AS
BEGIN
 new.id_op = gen_id(increment,1);
END^

---------------------------------

CREATE OR ALTER EXCEPTION ERROR_STAGE 'ERROR: CANNOT DELETE STAGE TYPE'^
CREATE OR ALTER TRIGGER check_stage FOR optionlist BEFORE DELETE 
AS
BEGIN
 IF (OLD.id_sale IN (SELECT id_sale FROM sale)) THEN
 EXCEPTION ERROR_STAGE;
END^

---------------------------------

CREATE OR ALTER EXCEPTION OPTALREADY 'OPTION IS ALREADY EXISTS'^
CREATE OR ALTER TRIGGER add_op FOR optionlist BEFORE insert 
AS
BEGIN
 IF (new.id_op IN (
		SELECT id_op 
		FROM comp_option as co
		join complectation using (id_comp)
		join modelcomplectation using (id_comp)
		join car_available using (id_mc)
		join sale using (id_car)
		where new.id_sale = sale.id_sale
		)
		) THEN
 EXCEPTION OPTALREADY;
END^

---------------------------------
-- Getting popular month options
CREATE OR ALTER EXCEPTION ex_monthOption 'not found any options for this month '^
CREATE OR ALTER PROCEDURE month_options(id_sale int)
returns (id_opt int)
as
	declare variable mon int;
	declare variable yea int;
begin
	id_opt = null;
	-- sale month and year
	select extract(MONTH from sale.dat),extract(YEAR from sale.dat)
	from sale
	where id_sale = :id_sale
	into :mon, :yea;
	mon = mon - 1;
	
	for
		-- all options for month
		select * from 
		(
			-- comp options for month
			select id_op 
			from comp_option
			join complectation using (id_comp)
			join modelcomplectation using (id_comp)
			join car_available using (id_mc)
			join sale using (id_car)
			where extract(MONTH from sale.dat) >= :mon
			and extract(YEAR from sale.dat) = :yea

			union all

			-- sale options for month
			select id_op 
			from optionlist
			join sale using (id_sale)
			where extract(MONTH from sale.dat) >= :mon
			and extract(YEAR from sale.dat) = :yea
		)
		group by id_op
		order by sum(id_op) desc
		into :id_opt
	do begin
		suspend;
	end
	if (id_opt = null) then exception ex_monthOption;
end^

-- Getting options of purchased car
CREATE OR ALTER PROCEDURE sales_options(id_sale int)
returns (id_opt int)
as
begin
	for
		-- comp options 
		select id_op 
		from comp_option
		join complectation using (id_comp)
		join modelcomplectation using (id_comp)
		join car_available using (id_mc)
		join sale using (id_car)
		where id_sale = :id_sale

		union 

		-- sale options 
		select id_op 
		from optionlist
		join sale using (id_sale)
		where id_sale = :id_sale
		into :id_opt
	do begin
		suspend;
	end
end ^

CREATE OR ALTER EXCEPTION ex_carOption 'unable to add an option in order '^
-- Adding extra option
create or alter procedure add_free_op(id_sale int)
as
	declare variable added_option int;
begin
	added_option = -1;
	
	select first 1 id_opt
	from month_options (:id_sale)
	where id_opt not in
	(select * from sales_options(:id_sale))
	into :added_option;

	if (:added_option = -1) then exception ex_carOption;
	
	INSERT INTO optionlist (id_oplist, id_op, id_sale)
	select max(optionlist.id_oplist)+1, :added_option, :id_sale
	from optionlist;
end^


create or alter trigger add_free_op for sale after insert
as
declare variable lim_price int;
declare variable summ int;
begin
lim_price = 10000;
if (new.totalprice > lim_price) then
	execute procedure add_free_op(new.id_sale);
end^



SET TERM ; ^