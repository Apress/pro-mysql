USE ToyStore;

INSERT INTO Product VALUES 
(1, 'ACT001', 'Action Figure - Tennis', 'Tennis Player Action Figure with Accessories', 0.65, 12.95)
, (2, 'ACT002', 'Action Figure - Football', 'Football Player Action Figure with Accessories', 0.65, 11.95)
, (3, 'ACT003', 'Action Figure - Gladiator', 'Roman Gladiator Action Figure', 0.85, 15.95)
, (4, 'SPT001', 'Soccer Ball', 'Standard Size 5 Soccer Ball', 1.25, 23.70)
, (5, 'SPT002', 'Tennis Balls', '3 Hard Court Tennis Balls', 0.75, 4.75)
, (6, 'SPT003', 'Tennis Racket', 'Fiberglass Tennis Racket', 2.15, 104.75)
, (7, 'DOL001', 'Doll', 'Collectible 1950\'s Doll', 3.75, 59.99)
, (8, 'VID001', 'Video Game - Car Racing', 'Formula 1 Racing Game', 0.25, 48.99)
, (9, 'VID002', 'Video Game - Soccer', 'Championship Soccer Video Game', 0.25, 44.99)
, (10, 'VID003', 'Video Game - Football', 'Professional Football Video Game', 0.25, 46.99);

INSERT INTO Category VALUES
(1, NULL, 'All', 'All Categories', 1, 28)
, (2, 1, 'Action Figures', 'All Types of Action Figures', 2, 11)
, (3, 2, 'Sport Action Figures', 'All Types of Action Figures in Sports', 3, 8)
, (4, 3, 'Tennis Action Figures', 'Tennis Action Figures', 4, 5)
, (5, 3, 'Football Action Figures', 'Football Action Figures', 6, 7)
, (6, 2, 'Historical Action Figures', 'Historical Action Figures', 9, 10)
, (7, 1, 'Video Games', 'All Types of Video Games', 12, 19)
, (8, 7, 'Racing Video Games', 'Racing Video Games', 13, 14)
, (9, 7, 'Sports Video Games', 'Sports Video Games', 15, 16)
, (10, 7, 'Shooting Video Games', 'Shooting Video Games', 17, 18)
, (11, 1, 'Sports Gear', 'All Types of Sports Gear', 20, 25)
, (12, 11, 'Soccer Equipment', 'Soccer Equipment', 21, 22)
, (13, 11, 'Tennis Equipment', 'Tennis Equipment', 23, 24)
, (14, 1, 'Dolls', 'All Types of Dolls', 26, 27);

INSERT INTO Product2Category VALUES
(1,3)
, (2,3)
, (3,6)
, (4,12)
, (5,13)
, (6,13)
, (7,14)
, (8,8)
, (9,9)
, (10,9);

INSERT INTO OrderStatus VALUES
('PR', 'In Progress')
, ('SH', 'Shipped')
, ('CM', 'Completed')
, ('CL', 'Closed')
, ('CN', 'Cancelled');

INSERT INTO ShippingMethod VALUES
(1, 'Light Weight Shipments', 10.00, 0.00, 10.00, 0.00, 200.00)
, (2, 'Medium Weight Shipments', 20.00, 10.01, 20.00, 0.00, 200.00)
, (3, 'Heavy Weight Shipments', 30.00, 20.01, 200.00, 0.00, 200.00)
, (4, 'Free Shipping', 0.00, 200.01, 99999.99, 200.01, 9999999.99);

INSERT INTO Customer VALUES
(1, 'johndoe', 'johndoe', '2004-12-07', 'John', 'Doe', '123 Billing St.', 'Doeville', 'NY', '10002', 'US', '123 Shipping St.', 'Doeville', 'NY', '10002', 'US')
, (2, 'janesmith', 'janesmith', '2004-12-10', 'Jane', 'Smith', '456 Billing Rd.', 'Smithville', 'CA', '90004', 'US', '456 Shipping Rd.', 'Smithville', 'CA', '90004', 'US')
, (3, 'markbrown', 'markbrown', '2004-12-31', 'Mark', 'Brown', '789 BillTo Dr.', 'Browntown', 'TX', '65498', 'US', '789 ShipTo Dr.', 'Browntown', 'TX', '65498', 'US')
, (4, 'homersimpson', 'homersimpson', '2005-02-01', 'Homer', 'Simpson', '444 Main St.', 'Springfield', 'IL', '46819', 'US', '44 Main St.', 'Springfield', 'IL', '46819', 'US');

INSERT INTO CustomerOrder VALUES
(1, 1, 'CM', 1, '2004-12-07', 10.00)
, (2, 1, 'CM', 2, '2004-12-08', 20.00)
, (3, 1, 'PR', 4, '2005-01-02', 0.00)
, (4, 2, 'CN', 4, '2005-01-02', 0.00)
, (5, 3, 'SH', 2, '2005-01-05', 20.00)
, (6, 3, 'SH', 3, '2005-01-05', 30.00);

INSERT INTO CustomerOrderItem VALUES
(1, 4, 23.70, 1.25, 1)
, (2, 5, 4.75, 0.75, 15)
, (2, 1, 12.95, 0.65, 1)
, (3, 7, 59.99, 3.75, 2)
, (4, 10, 46.99, 0.25, 1)
, (4, 6, 104.75, 2.15, 1)
, (5, 2, 11.95, 0.65, 1)
, (5, 3, 15.95, 0.85, 1)
, (5, 5, 4.75, 0.75, 12)
, (6, 5, 4.75, 0.75, 30);