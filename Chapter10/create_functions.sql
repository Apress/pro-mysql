drop database if exists shop;

create database shop;
use shop;

CREATE TABLE cust_order (
   cust_order_id integer unsigned primary key auto_increment not null,
   order_date date,
   item_sum decimal(10,2) default NULL,
   rush_ship int default 0);

delimiter //

create function calc_total (item_sum decimal(10,2), rush_ship int) returns decimal(10,2)
begin

declare order_total decimal(10,2);

set order_total = item_sum + calc_tax(item_sum) + 
calc_shipping(item_sum) + calc_rush_shipping(rush_ship);
return round(order_total,2);

end
//

create function calc_tax (cost decimal(10,2)) returns decimal(10,2) 
return cost * .05

//
delimiter ;

delimiter //
create function delivery_day_shipping (delivery_day int(1)) returns int(2)
begin

declare shipping_cost int(2) default 0;

if delivery_day = 1 then 
        set shipping_cost = 20;
elseif delivery_day = 2 then 
        set shipping_cost = 15;
elseif delivery_day = 3 then 
        set shipping_cost = 10;
else 
        set shipping_cost = 5;
end if;

return shipping_cost;

end
//
delimiter ;

delimiter //
create function delivery_day_shipping_case (delivery_day int(1)) returns int(2)
begin

declare shipping_cost int(2) default 0;

case delivery_day
when 1 then 
        set shipping_cost = 20;
when 2 then 
        set shipping_cost = 15;
when 3 then 
        set shipping_cost = 10;
else 
        set shipping_cost = 5;
end case;
return shipping_cost;

end
//
delimiter ;

delimiter //
create function delivery_day_shipping_case_when (delivery_day int(1),preferred int(1)) returns int(2)
begin

declare shipping_cost int(2) default 0;

case
when preferred = 1 then
	set shipping_cost = 2;
when delivery_day = 1 then 
        set shipping_cost = 20;
when delivery_day = 2 then 
        set shipping_cost = 15;
when delivery_day = 3  then 
        set shipping_cost = 10;
else 
        set shipping_cost = 5;
end case;
return shipping_cost;

end
//
delimiter ;

delimiter //
create function calc_shipping (cost decimal(10,2)) returns decimal(10,2) 
begin

declare shipping_cost decimal(10,2);

set shipping_cost = 0;
if cost < 25.00 then
	set shipping_cost = 10.00;
elseif cost < 100.00 then
	set shipping_cost = 20.00;
elseif cost < 200.00 then
	set shipping_cost = 30.00;
else
	set shipping_cost = 40.00;
end if;

return shipping_cost;
end
//

create function calc_rush_shipping (rush_ship int) returns decimal(10,2)
begin

declare rush_shipping_cost decimal(10,2);

case rush_ship
when 1 then 
        set rush_shipping_cost = 20.00;
when 2 then 
        set rush_shipping_cost = 15.00;
when 3 then 
	set rush_shipping_cost = 10.00;
else
	set rush_shipping_cost = 0.00;
end case;

return rush_shipping_cost;

end
//

delimiter ;

delimiter //
create function round_up_dozen (quantity int(10)) returns int(10)
begin

while quantity mod 12 > 0 do
set quantity = quantity + 1;
end while;

return quantity;

end
//
delimiter ;

delimiter //
create function order_quantity (quantity int(10)) returns int(10)
begin

repeat
set quantity = quantity + 1;
until quantity mod 12 = 0
end repeat;

return quantity;

end
//

delimiter ;

delimiter //
create function find_common_multiple (quantity int(10)) returns int(10)
begin

increment: loop

if quantity mod 12 > 0 then
set quantity = quantity + 1;
iterate increment;
end if;

if quantity mod 8 < 1 then
leave increment;
end if;

set quantity = quantity + 1;

end loop increment;

return quantity;

end
//

delimiter ;

delimiter //
create function round_down_tenth (quantity int(10)) returns int(10)
begin

increment: loop

if quantity mod 10 < 1 then 
leave increment;
end if;

set quantity = quantity - 1;

end loop increment;

return quantity;

end
//

delimiter ;

INSERT INTO cust_order
(cust_order_id, order_date, item_sum, rush_ship)
VALUES 
(1,'2005-08-31',30.95,1),
(2,'2005-08-27',40.56,3),
(3,'2005-09-27',214.34,null),
(4,'2005-09-01',143.65,null),
(5,'2005-09-10',345.99,5),
(6,'2005-08-28',789.24,1),
(7,'2005-09-01',3.45,1);

create function ucasefirst (phrase varchar(255)) returns varchar(255)
return concat(ucase(substr(phrase,1,1)),substr(lcase(phrase),2));

delimiter //

create function perform_logic (some_input int(10)) returns int(10)
begin
	declare problem condition for 1365;
	declare exit handler for problem
		return 0;

	# do some logic, if the problem condition is met 
        # the function will exit, returning a 0

	return 1;
end
//

delimiter ;
