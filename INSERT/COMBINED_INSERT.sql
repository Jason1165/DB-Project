INSERT INTO coach VALUES 
(1, 'Michael Malone', 52, '2015-06-15', NULL, 4000000), 
(2, 'Jacque Vaughn', 49, '2022-11-01', NULL, 3500000), 
(3, 'Brian Keefe', 46, '2024-01-25', NULL, 2800000), 
(4, 'Steve Kerr', 58, '2014-05-19', NULL, 7500000), 
(5, 'Will Hardy', 36, '2022-06-29', NULL, 3200000), 
(6, 'Gregg Popovich', 75, '1996-12-10', NULL, 11000000), 
(7, 'Mike Brown', 54, '2022-05-09', NULL, 4500000), 
(8, 'Erik Spoelstra', 53, '2008-04-28', NULL, 8500000), 
(9, 'J.B. Bickerstaff', 45, '2021-03-10', NULL, 3800000), 
(10, 'Tom Thibodeau', 67, '2020-07-30', NULL, 6500000),
(11, 'Phil Jackson', 78, '1989-07-10', '2011-05-08', 12000000),
(12, 'Pat Riley', 79, '1981-11-19', '2008-04-16', 9500000),
(13, 'Red Auerbach', 89, '1950-05-15', '1966-04-28', 800000),
(14, 'Jerry Sloan', 78, '1988-12-09', '2011-02-10', 5200000),
(15, 'Don Nelson', 84, '1976-10-14', '2010-04-14', 6100000);


INSERT INTO donation (donationID, teamID, sponsorID, amount) VALUES
(1, 3, 7, 5),
(2, 1, 2, 9),
(3, 5, 4, 2),
(4, 8, 6, 10),
(5, 2, 1, 4),
(6, 10, 3, 6),
(7, 6, 9, 3),
(8, 9, 8, 7),
(9, 4, 10, 8),
(10, 7, 5, 1);

INSERT INTO `match` VALUES
(1, 1, 4, 1, 3, 1, 10, '112-108', 150.00, '2025-02-15'),
(2, 8, 2, 8, 1, 2, 10, '105-98', 175.00, '2025-02-18'),
(3, 10, 9, 10, 6, 3, 9, '118-101', 300.00, '2025-02-20'),
(4, 6, 7, 6, 7, 4, 9, '97-104', 125.00, '2025-02-22'),
(5, 3, 5, 3, 2, 5, 8, '115-110', 135.00, '2025-02-25'),
(6, 4, 1, 4, 5, 6, 8, '121-119', 250.00, '2025-03-01'),
(7, 2, 10, 2, 4, 7, 7, '99-112', 225.00, '2025-03-03'),
(8, 5, 7, 5, 9, 8, 7, '108-95', 110.00, '2025-03-05'),
(9, 9, 8, 9, 10, 1, 6, '102-113', 85.00, '2025-03-08'),
(10, 6, 3, 6, 8, 2, 6, '125-98', 135.00, '2025-03-10');


INSERT INTO player VALUES
(1, 1, 'Nikola Jokic', 'C', 15, 83, 29, 47600000),
(2, 2, 'Mikal Bridges', 'SF', 1, 78, 27, 23300000),
(3, 3, 'Jordan Poole', 'SG', 13, 76, 24, 27500000),
(4, 4, 'Stephen Curry', 'PG', 30, 74, 36, 51900000),
(5, 5, 'Lauri Markkanen', 'PF', 23, 84, 27, 18000000),
(6, 6, 'Victor Wembanyama', 'PF', 1, 88, 20, 12500000),
(7, 7, 'DeAaron Fox', 'PG', 5, 75, 26, 32600000),
(8, 8, 'Jimmy Butler', 'SF', 22, 79, 34, 45200000),
(9, 9, 'Cade Cunningham', 'PG', 2, 78, 22, 11055360),
(10, 10, 'Jalen Brunson', 'PG', 11, 74, 27, 26346666),
(11, 1, 'Christian Braun', 'SG', 0, 79, 23, 2939280),
(12, 2, 'Michael Jordan', 'SG', 23, 78, 60, 33140000),
(13, 6, 'Kobe Bryant', 'SG', 24, 78, 41, 25000000),
(14, 8, 'Dwyane Wade', 'SG', 3, 76, 42, 20000000),
(15, 10, 'Patrick Ewing', 'C', 33, 84, 62, 18724000),
(16, 2, 'Magic Johnson', 'PG', 32, 81, 64, 14660000),
(17, 4, 'Wilt Chamberlain', 'C', 13, 85, 63, 10000000),
(18, 3, 'Larry Bird', 'SF', 33, 81, 67, 7070000),
(19, 5, 'John Stockton', 'PG', 12, 73, 62, 6000000),
(20, 9, 'Bill Russell', 'C', 6, 82, 89, 100000);


INSERT INTO playoff VALUES
(1, 2, 4, 4),
(2, 4, 8, 8),
(3, 6, 4, 4),
(4, 8, 1, 1),
(5, 10, 10, 10),
(6, 1, 3, 3),
(7, 3, 9, 9),
(8, 5, 7, 7),
(9, 7, 2, 2),
(10, 9, 5, 5);


INSERT INTO referee VALUES
(1, 4, 'Scott Foster', 57, '1994-09-30', NULL),
(2, 8, 'Tony Brothers', 59, '1994-10-15', NULL),
(3, 1, 'Marc Davis', 55, '1998-12-10', NULL),
(4, 10, 'James Capers', 61, '1995-01-25', NULL),
(5, 3, 'Zach Zarba', 49, '2003-04-12', NULL),
(6, 7, 'Ed Malloy', 53, '2002-09-05', NULL),
(7, 5, 'John Goble', 47, '2007-11-30', NULL),
(8, 2, 'David Guthrie', 48, '2005-03-18', NULL),
(9, 6, 'Joey Crawford', 72, '1977-05-12', '2016-04-10'),
(10, 9, 'Dick Bavetta', 84, '1975-12-02', '2014-08-20');


INSERT INTO team VALUES
(1, 1, 1, 3, 2, 'Denver Nuggets', 1, 3, 350000000),
(2, 2, 2, 1, 1, 'Brooklyn Nets', 0, 1, 310000000),
(3, 3, 3, 5, 1, 'Washington Wizards', 1, 4, 320000000),
(4, 4, 4, 9, 2, 'Golden State Warriors', 7, 12, 510000000),
(5, 5, 5, 8, 2, 'Utah Jazz', 0, 2, 340000000),
(6, 6, 6, 4, 2, 'San Antonio Spurs', 5, 10, 390000000),
(7, 7, 7, 10, 2, 'Sacramento Kings', 0, 1, 300000000),
(8, 8, 8, 2, 1, 'Miami Heat', 3, 9, 380000000),
(9, 9, 9, 6, 1, 'Detroit Pistons', 3, 5, 290000000),
(10, 10, 10, 7, 1, 'New York Knicks', 2, 8, 425000000);


INSERT INTO bracket VALUES
(1, 8, 'Play-In 2020'),
(2, 16, 'Play-Offs 2020'),
(3, 8, 'Play-In 2021'),
(4, 16, 'Play-Offs 2021'),
(5, 8, 'Play-In 2022'),
(6, 16, 'Play-Offs 2022'),
(7, 8, 'Play-In 2023'),
(8, 16, 'Play-Offs 2023'),
(9, 8, 'Play-In 2024'),
(10, 16, 'Play-Offs 2024');

INSERT INTO conference VALUES 
(1, 'Eastern Conference'),
(2, 'Western Conference'),
(3, 'Atlantic Coast Conference'),
(4, 'Big Ten Conference'),
(5, 'Big 12 Conference'),
(6, 'Pac-12 Conference'),
(7, 'Southeastern Conference'),
(8, 'Big East Conference'),
(9, 'American Athletic Conference'),
(10, 'Mountain West Conference'),
(11, 'Atlantic 10 Conference'),
(12, 'West Coast Conference'),
(13, 'Conference USA');


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

INSERT INTO stadium VALUES
(1, 'Ball Arena', 'Denver, Colorado', 19200, 356),
(2, 'Barclays Center', 'Brooklyn, New York', 17732, 750),
(3, 'Capital One Arena', 'Washington, D.C.', 20356, 1000),
(4, 'Chase Center', 'San Francisco, California', 18064, 700),
(5, 'Delta Center', 'Salt Lake City, Utah', 18306, 367),
(6, 'Frost Bank Center', 'San Antonio, Texas', 18418, 9),
(7, 'Golden 1 Center', 'Sacramento, California', 17583, 665),
(8, 'Kaseya Center', 'Miami, Florida', 19600, 2),
(9, 'Little Caesars Arena', 'Detroit, Michigan', 20332, 100),
(10, 'Madison Square Garden', 'New York City, New York', 19812, 959);


INSERT INTO streaming_service VALUES
(1, 'DIRECTV Stream', 79.99, 4),
(2, 'Hulu', 7.99, 4),
(3, 'NBA TV', 6.99, 4),
(4, 'Sling TV', 61.00, 3),
(5, 'YouTube TV', 82.99, 4),
(6, 'ESPN+', 10.99, 4),
(7, 'Fubo', 74.99, 4),
(8, 'NBA League Pass', 14.99, 4),
(9, 'Max', 16.99, 4),
(10, 'Amazon Prime', 14.99, 4);


