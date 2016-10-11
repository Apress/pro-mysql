drop database if exists shop;

create database shop;

use shop;

create table city (city_id integer not null auto_increment primary key,
name varchar(50));
insert into city (name) values ('Boston'),('Columbus'),('London'),('Berlin');

create table customer (customer_id integer not null auto_increment primary key, 
name varchar (10), 
region integer);
insert into customer values (1,'Mike',1);
insert into customer values (2,'Jay',2);
insert into customer values (3,'Johanna',2);
insert into customer values (4,'Michael',1);
insert into customer values (5,'Heidi',3);
insert into customer values (6,'Ezra',3);

load data infile '/home/mkruck01/Personal/Pro MySQL/grandforks/Chapter11/customer_data.csv' 
into table customer fields terminated by ',' (name,region);

create table login (login_id integer not null auto_increment primary key, 
customer_id integer, 
login_time datetime,
login_unixtime integer);

load data infile '/home/mkruck01/personal/Pro MySQL/grandforks/Chapter11/login_data.csv' 
into table login fields terminated by ',' (customer_id,login_unixtime);

update login set login_time = from_unixtime(login_unixtime);

create index name on customer (name);
create index region on customer (region);
create index customer_id on login (customer_id);

create table login_northeast (login_id integer not null auto_increment primary key, 
customer_id integer, 
login_time datetime);

create table login_northwest (login_id integer not null auto_increment primary key, 
customer_id integer, 
login_time datetime);

create table login_south (login_id integer not null auto_increment primary key, 
customer_id integer, 
login_time datetime);

DROP FUNCTION IF EXISTS city_list;

DELIMITER //
CREATE FUNCTION city_list() returns varchar(255)
BEGIN

	DECLARE finished INTEGER DEFAULT 0;
	DECLARE city_name VARCHAR(50) DEFAULT "";
	DECLARE list VARCHAR(255) DEFAULT "";
	DECLARE city_cur CURSOR FOR SELECT name FROM city ORDER BY name;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN city_cur;

	get_city: LOOP
		FETCH city_cur INTO city_name;
		IF finished THEN 
			LEAVE get_city;
		END IF;
		SET list = CONCAT(list,", ",city_name);
	END LOOP get_city;
	
	CLOSE city_cur;

	RETURN SUBSTR(list,3);

END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS login_archive;
DELIMITER //

CREATE PROCEDURE login_archive()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE cust_id INTEGER;
	DECLARE log_id INTEGER;
	DECLARE time DATETIME;
	DECLARE moved_count INTEGER DEFAULT 0;
	DECLARE customer_region INTEGER;

	DECLARE login_curs CURSOR FOR SELECT l.customer_id, l.login_time, c.region, l.login_id
		FROM login l, customer c
		WHERE l.customer_id = c.customer_id
		AND to_days(l.login_time) < to_days(now())-7;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN login_curs;

	move_login: LOOP

	FETCH login_curs INTO cust_id, time, customer_region, log_id;

	IF finished THEN
		LEAVE move_login;
	END IF;

	IF customer_region = 1 THEN
		INSERT INTO login_northeast SET customer_id = cust_id, login_time = time;		
	ELSEIF customer_region = 2 THEN
		INSERT INTO login_northwest SET customer_id = cust_id, login_time = time;		
	ELSE
		INSERT INTO login_south SET customer_id = cust_id, login_time = time;		
	END IF;

	DELETE from login where login_id = log_id;

	SET moved_count = moved_count + 1;

	END LOOP move_login;

	CLOSE login_curs;

	SELECT moved_count as 'records archived';

END
//

DELIMITER ;
