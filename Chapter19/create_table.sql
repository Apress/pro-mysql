CREATE TABLE customer (
customer_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(10)
) ENGINE=NDBCLUSTER;

INSERT INTO customer VALUES (1,'Mike'), 
(2,'Jay'),
(3,'Johanna'),
(4,'Michael'),
(5,'Heidi'),
(6,'Ezra');
