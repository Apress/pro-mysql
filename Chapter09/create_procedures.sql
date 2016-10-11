## create table and some data
drop database if exists shop;
create database shop;
use shop;
drop table if exists customer;
drop table if exists address;
drop table if exists payment;
drop table if exists cust_order;

create table customer (customer_id integer not null auto_increment primary key, name varchar (10));
insert into customer values (1,'Mike');
insert into customer values (2,'Jay');
insert into customer values (3,'Johanna');
insert into customer values (4,'Michael');
insert into customer values (5,'Heidi');
insert into customer values (6,'Ezra');

create table address (address_id integer, customer_id integer, address varchar(100));
insert into address values (1,1,'123 My Street');
insert into address values (2,1,'456 My Business Street');
insert into address values (3,2,'123 That Street');
insert into address values (4,2,'456 Another Business Street');
insert into address values (5,3,'123 Home Street');
insert into address values (6,3,'456 Work Street');
insert into address values (7,4,'789 My Parent''s Street');
insert into address values (8,4,'123 My Street');

create table payment (payment_id integer, customer_id integer, payment_information varchar(100));
insert into payment values (1,1,'credit card information');
insert into payment values (2,1,'checking account information');
insert into payment values (3,2,'credit card information');
insert into payment values (4,2,'online billpay information');
insert into payment values (5,3,'purchase order information');
insert into payment values (6,3,'credit card information');
insert into payment values (7,3,'cash in brown bag information');
insert into payment values (8,4,'credit card information');

create table cust_order (cust_order_id integer, customer_id integer, address_id integer, payment_id integer, order_item_id integer, ship_date date);
insert into cust_order values (1,1,1,2,1,'2005-08-31');
insert into cust_order values (2,1,2,1,2,'2005-08-27');
insert into cust_order values (3,2,3,3,3,'2005-09-27');
insert into cust_order values (4,2,3,4,4,'2005-09-01');
insert into cust_order values (5,3,6,5,5,'2005-09-10');
insert into cust_order values (6,3,5,6,6,'2005-08-28');
insert into cust_order values (7,4,8,8,7,'2005-09-01');

drop procedure if exists get_customers;

## stored procedure to select customers
create procedure get_customers ()
select customer_id,name from customer;

drop procedure if exists merge_customers;

## stored procedure to merge customer records
delimiter //
create procedure merge_customers (IN old_id INT, IN new_id INT, OUT error VARCHAR(100)) SQL SECURITY DEFINER
BEGIN
	declare old_count INT default 0;
	declare new_count INT default 0;
	declare addresses_changed INT default 0;
	declare payments_changed INT default 0;
	declare orders_changed INT default 0;

        ## check to make sure the old_id and new_id exists
	select count(*) into old_count from customer where customer_id = old_id;
	select count(*) into new_count from customer where customer_id = new_id;
	if !old_count then 
	    set error = 'old id does not exist';
	elseif !new_count then
	    set error = 'new id does not exist';
	else ## update all the auxiliary tables and delete the customer record
	    update address set customer_id = new_id where customer_id = old_id;
	    select row_count() into addresses_changed;

	    update payment set customer_id = new_id where customer_id = old_id;
	    select row_count() into payments_changed;

	    update cust_order set customer_id = new_id where customer_id = old_id;
	    select row_count() into orders_changed;

	    delete from customer where customer_id = old_id;

	    select addresses_changed,payments_changed,orders_changed;

        end if;
END
//
delimiter ;

drop procedure if exists update_name;

delimiter //
create procedure update_name (IN cust_id INT, IN new_name VARCHAR(10), OUT error VARCHAR(100))
BEGIN
	declare old_name varchar(10);
	declare truncated_name CONDITION for 1265;
	declare exit handler for truncated_name 
           update customer set name = old_name where customer_id = cust_id;

	select name into old_name from customer where customer_id = cust_id;
	update customer set name = new_name where customer_id = cust_id;

	select customer_id,name from customer where customer_id = cust_id;
END
//

delimiter ;

drop procedure if exists get_shipping_cost_if;
drop procedure if exists get_shipping_cost;
drop procedure if exists get_shipping_cost_caseif;
drop procedure if exists test_loop;

delimiter //
create procedure get_shipping_cost_if (IN delivery_day INT)
BEGIN
	declare shipping INT;
	if delivery_day = 1 then set shipping = 20;
	elseif delivery_day = 2 then set shipping = 15;
	elseif delivery_day = 3 then set shipping = 10;
	else set shipping = 5;
	end if;

	select shipping;
END
//

create procedure get_shipping_cost (IN delivery_day INT)
SQL SECURITY DEFINER COMMENT 'determine shipping cost based on day of delivery'
BEGIN
	declare shipping INT;
	case delivery_day
	when 1 then set shipping = 20;
	when 2 then set shipping = 15;
	when 3 then set shipping = 10;
	else set shipping = 5;
	end case;

	select shipping;
END
//

create procedure get_shipping_cost_caseif (IN delivery_day INT)
BEGIN
	declare shipping INT;
	case
	when delivery_day = 1 then set shipping = 20;
	when delivery_day = 2 then set shipping = 15;
	when delivery_day = 3  then set shipping = 10;
	else set shipping = 5;
	end case;

	select shipping;
END
//

drop procedure if exists increment//

create procedure increment (IN in_count INT)
BEGIN
declare count INT default 0;

increment: loop
set count = count + 1;
if count < 20 then iterate increment; end if;
if count > in_count then leave increment;
end if;
end loop increment;

select count;
END
//

drop procedure if exists test_while//

create procedure test_while (IN in_count INT)
BEGIN
declare count INT default 0;

while count < 10 do
set count = count + 1;
end while;

select count;
END
//

drop procedure if exists test_repeat//

create procedure test_repeat (IN in_count INT)
BEGIN
declare count INT default 0;

increment: repeat set count = count + 1; 
until count > 10 
end repeat increment;

END
//

delimiter ;

