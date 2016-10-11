drop database if exists shop;
create database shop;

use shop; 

CREATE TABLE cust_order (
  `cust_order_id` integer unsigned primary key auto_increment not null,
  `ship_date` date default NULL,
   item_sum decimal(10,2) default NULL,
   discount_percent integer(2) unsigned default NULL,
   shipping decimal(10,2) default 0,
   total decimal(10,2) default NULL
);

delimiter //

create trigger before_cust_order_insert before insert on cust_order
for each row
begin

if NEW.discount_percent > 15 then
	set NEW.discount_percent = 15;
end if;

if NEW.discount_percent is null or NEW.discount_percent = 0 then
	set NEW.total = NEW.item_sum + NEW.shipping;
else
	set NEW.total = NEW.item_sum - 
	(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;
end if;
end
//

create trigger before_cust_order_update before update on cust_order
for each row
begin

if OLD.discount_percent + 2 <= NEW.discount_percent then
	set NEW.discount_percent = OLD.discount_percent + 2;
end if;

if NEW.discount_percent > 15 then
	set NEW.discount_percent = 15;
end if;

if NEW.discount_percent is null or NEW.discount_percent = 0 then
	set NEW.total = NEW.item_sum + NEW.shipping;
else
	set NEW.total = NEW.item_sum - 
	(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;
end if;
end
//

#create trigger before_customer_insert before insert on customer
#for each row
#begin
#declare delete_count integer;
#DECLARE truncated_name CONDITION FOR 1265;
#        declare exit handler for truncated_name set @loc_err = 'error';
#set NEW.name = 'MichaelJKruckenbergShouldBeTooLongForTheField';
#end
#//

delimiter ;

INSERT INTO cust_order
(cust_order_id, ship_date, item_sum, discount_percent, shipping)
VALUES 
(1,'2005-08-31',30.95,14,3.25),
(2,'2005-08-27',40.56,10,10.34),
(3,'2005-09-27',214.34,null,18.28),
(4,'2005-09-01',143.65,null,15.43),
(5,'2005-09-10',345.99,null,10.45),
(6,'2005-08-28',789.24,18,25.76),
(7,'2005-09-01',3.45,10,1.25);

create table customer (customer_id integer not null auto_increment primary key, name varchar (10));

insert into customer values (1,'Mike');
insert into customer values (2,'Jay');
insert into customer values (3,'Johanna');
insert into customer values (4,'Michael');
insert into customer values (5,'Heidi');
insert into customer values (6,'Ezra');

CREATE TABLE customer_audit (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, 
action CHAR(50), 
customer_id INTEGER, 
name VARCHAR(50), 
changed DATETIME);

DELIMITER //

CREATE TRIGGER before_customer_delete BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
INSERT INTO customer_audit 
SET action='delete', 
customer_id = OLD.customer_id, 
name = OLD.name, 
changed = now();
END

//

CREATE TRIGGER before_customer_update BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
INSERT INTO customer_audit 
SET action='update', 
customer_id = OLD.customer_id, 
name = OLD.name, 
changed = now();
END

//

#create trigger after_customer_update after update on customer 
#for each row 
#Bbegin
#if @update_count is null then 
#   set @update_count = 0; 
#end if;
#set @update_count = @update_count + 1;
#end
#//

CREATE TRIGGER after_cust_order_delete AFTER DELETE on cust_order
FOR EACH ROW
BEGIN
IF @insert_count IS NULL THEN
	SET @insert_count = 0; 
END IF;
SET @insert_count = @insert_count + 1;
END
//

DELIMITER ;
