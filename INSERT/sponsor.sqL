--USE INSERTNAMEHERE

CREATE TABLE sponsor (
    sponsorID NUMERIC(6),
    name VARCHAR(50),
    money FLOAT,
    PRIMARY KEY(sponsorID)
);

INSERT INTO sponsor VALUES
(1, 'Ticketmaster', 5),  
(2, 'Chick-fil-A', 1),  
(3, 'Coca-Cola', 10),  
(4, 'Quick Quack Car Wash', 0.5),  
(5, 'Toyota', 3),  
(6, 'Taco Bell', 2),  
(7, 'State Farm', 13.7),  
(8, 'Sports California', 0.5),  
(9, 'Corona Extra', 1.5),  
(10, 'UPS', 1);