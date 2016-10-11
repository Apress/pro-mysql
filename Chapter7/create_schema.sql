CREATE DATABASE ToyStore;

USE ToyStore;

CREATE TABLE Product (
    product_id  INT NOT NULL AUTO_INCREMENT
    , sku   VARCHAR(35) NOT NULL
    , name  VARCHAR(150) NOT NULL
    , description TEXT NOT NULL
    , weight DECIMAL(7,2) NOT NULL
    , unit_price DECIMAL(9,2) NOT NULL
    , PRIMARY KEY (product_id)
);

CREATE TABLE Category (
    category_id INT NOT NULL AUTO_INCREMENT
    , parent_id INT NULL
    , name VARCHAR(100) NOT NULL
    , description TEXT
    , left_side INT NULL
    , right_side INT NULL
    , PRIMARY KEY (category_id)
    , INDEX (parent_id)
);

CREATE TABLE Product2Category (
    product_id INT NOT NULL
    , category_id INT NOT NULL
    , PRIMARY KEY (product_id, category_id)
);

CREATE TABLE Customer (
    customer_id INT NOT NULL AUTO_INCREMENT
    , login VARCHAR(32) NOT NULL
    , password VARCHAR(32) NOT NULL
    , created_on DATE NOT NULL
    , first_name VARCHAR(30) NOT NULL
    , last_name VARCHAR(30) NOT NULL
    , billing_address VARCHAR(100) NOT NULL
    , billing_city VARCHAR(35) NOT NULL
    , billing_province CHAR(2) NOT NULL
    , billing_postcode VARCHAR(8) NOT NULL
    , billing_country CHAR(2) NOT NULL
    , shipping_address VARCHAR(100) NOT NULL
    , shipping_city VARCHAR(35) NOT NULL
    , shipping_province CHAR(2) NOT NULL
    , shipping_postcode VARCHAR(8) NOT NULL
    , shipping_country CHAR(2) NOT NULL
    , PRIMARY KEY (customer_id)
    , INDEX (login, password)
);

CREATE TABLE OrderStatus (
    order_status_id CHAR(2) NOT NULL
    , description VARCHAR(150) NOT NULL
    , PRIMARY KEY (order_status_id)
);

CREATE TABLE ShippingMethod (
    shipping_method_id INT NOT NULL AUTO_INCREMENT
    , name VARCHAR(100) NOT NULL
    , cost DECIMAL(5,2) NOT NULL
    , min_order_weight DECIMAL(9,2) NOT NULL
    , max_order_weight DECIMAL(9,2) NOT NULL
    , min_order_total DECIMAL(9,2) NOT NULL
    , max_order_total DECIMAL(9,2) NOT NULL
    , PRIMARY KEY (shipping_method_id)
);

CREATE TABLE CustomerOrder (
    order_id INT NOT NULL AUTO_INCREMENT
    , customer_id INT NOT NULL
    , status CHAR(2) NOT NULL
    , shipping_method INT NOT NULL
    , ordered_on DATE NOT NULL
    , shipping_price DECIMAL(5,2) NOT NULL
    , PRIMARY KEY (order_id)
);

CREATE TABLE CustomerOrderItem (
    order_id INT NOT NULL
    , product_id INT NOT NULL
    , price DECIMAL(9,2) NOT NULL
    , weight DECIMAL(7,2) NOT NULL
    , quantity INT NOT NULL
    , PRIMARY KEY (order_id, product_id) 
);
