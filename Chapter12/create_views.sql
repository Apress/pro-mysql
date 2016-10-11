drop database if exists shop;

create database shop;

use shop;

reset query cache;

create table customer (customer_id integer not null auto_increment primary key, region int(10), name varchar (10));
insert into customer values (1,1,'Mike');
insert into customer values (2,1,'Jay');
insert into customer values (3,2,'Johanna');
insert into customer values (4,2,'Michael');
insert into customer values (5,3,'Heidi');
insert into customer values (6,3,'Ezra');

create table address (address_id integer, customer_id integer, address varchar(100));
insert into address values (1,1,'123 My Street');
insert into address values (2,1,'456 My Business Street');
insert into address values (3,2,'123 That Street');
insert into address values (4,2,'456 Another Business Street');
insert into address values (5,3,'123 Home Street');
insert into address values (6,3,'456 Work Street');
insert into address values (7,4,'789 My Parent''s Street');
insert into address values (8,4,'123 My Street');

create table cust_order (cust_order_id integer, customer_id integer, address_id integer, payment_id integer, 
order_item_id integer, ship_date date);
insert into cust_order values (1,1,1,2,1,'2005-08-31');
insert into cust_order values (2,1,2,1,2,'2005-08-27');
insert into cust_order values (3,2,3,3,3,'2005-09-27');
insert into cust_order values (4,2,3,4,4,'2005-09-01');
insert into cust_order values (5,3,6,5,5,'2005-09-10');
insert into cust_order values (6,3,5,6,6,'2005-08-28');
insert into cust_order values (7,4,8,8,7,'2005-09-01');

CREATE ALGORITHM = TEMPTABLE VIEW customer_region1 AS 
SELECT customer_id, name FROM customer WHERE region = 1;

CREATE ALGORITHM = TEMPTABLE VIEW all_orders
(order_id,ship_date,region,customer_id,name,address) AS
SELECT o.cust_order_id, o.ship_date, c.region, c.customer_id, c.name, a.address 
FROM customer c, address a, cust_order o
WHERE o.customer_id = c.customer_id
AND c.customer_id = a.customer_id
AND o.customer_id = a.customer_id 
AND o.address_id = a.address_id;

CREATE ALGORITHM = TEMPTABLE VIEW ship_summary
(date,number_of_orders) AS
SELECT ship_date, count(ship_date)
FROM cust_order
GROUP BY ship_date;

CREATE ALGORITHM = TEMPTABLE VIEW small_ship_dates
(ship_date, number_of_orders) AS
SELECT ship_date, count(ship_date)
FROM cust_order
GROUP BY ship_date
HAVING count(ship_date) < 2
ORDER BY ship_date;

create or replace algorithm = merge view customer_address (customer_id,name,address) as 
select c.customer_id, c.name, a.address 
from customer c, address a 
where c.customer_id = a.customer_id 
with check option;

drop database if exists region1;
create database region1;
use region1;
create table region1.customer as select * from shop.customer where region = 1;
alter table customer drop column region;

drop database if exists region2;
create database region2;
use region2;
create table region2.customer as select * from shop.customer where region = 2;
alter table customer drop column region;

drop database if exists region3;
create database region3;
use region3;
create table region3.customer as select * from shop.customer where region = 0;
insert into customer values (1,3,'Pete');
insert into customer values (2,3,'Lora');
insert into customer values (3,3,'Jill');
alter table customer drop column region;

use shop;

CREATE VIEW all_customers AS
SELECT * FROM region1.customer
UNION SELECT * FROM region2.customer 
UNION SELECT * FROM region3.customer;

CREATE OR REPLACE VIEW all_customers (region, customer_id, name) AS
SELECT 1, customer_id, name FROM region1.customer
UNION SELECT 2, customer_id, name FROM region2.customer 
UNION SELECT 3, customer_id, name FROM region3.customer;

CREATE OR REPLACE VIEW customer_region1 AS 
SELECT customer_id, name, region FROM customer
WHERE region = 1 WITH LOCAL CHECK OPTION;

ALTER VIEW all_customers (region,customer_id,name,name_length) 
AS SELECT 'northeast', customer_id, upper(name), length(name) FROM region1.customer
UNION SELECT 'northwest', customer_id, upper(name), length(name) FROM region2.customer
UNION SELECT 'south', customer_id, upper(name), length(name) FROM region3.customer;

CREATE OR REPLACE ALGORITHM = TEMPTABLE VIEW customer_region3 AS 
SELECT customer_id, name, region FROM customer
WHERE region = 3;

