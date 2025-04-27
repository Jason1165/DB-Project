SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `ratingAuditLog`;
DROP TABLE IF EXISTS `rating`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `match`;
DROP TABLE IF EXISTS `playoff`;
DROP TABLE IF EXISTS `donation`;
DROP TABLE IF EXISTS `player`;
DROP TABLE IF EXISTS `referee`;
DROP TABLE IF EXISTS `team`;
DROP TABLE IF EXISTS `bracket`;
DROP TABLE IF EXISTS `streaming_service`;
DROP TABLE IF EXISTS `conference`;
DROP TABLE IF EXISTS `sponsor`;
DROP TABLE IF EXISTS `stadium`;
DROP TABLE IF EXISTS `coach`;
SET foreign_key_checks = 1;

CREATE TABLE coach (
    coachID INT AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    salary float,
    PRIMARY KEY(coachID)
);


CREATE TABLE stadium (
    stadiumID INT AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100),
    capacity INT,
    revenue INT,
    PRIMARY KEY(stadiumId)
);

CREATE TABLE sponsor (
    sponsorID INT AUTO_INCREMENT,
    name VARCHAR(100),
    money FLOAT,
    PRIMARY KEY(sponsorID)
);

CREATE TABLE conference (
    conferenceID INT AUTO_INCREMENT,
    side VARCHAR(100),
    PRIMARY KEY (conferenceID)
);


CREATE TABLE streaming_service (
    streamingID INT AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(5,2),
    rating FLOAT,
    numRatings INT,
    streamingLink VARCHAR(255),
    PRIMARY KEY (streamingID)
);

CREATE TABLE bracket (
    bracketID INT AUTO_INCREMENT,
    numTeams INT,
    season VARCHAR(100),
    PRIMARY KEY (bracketID)
);

CREATE TABLE team (
    teamID INT AUTO_INCREMENT,
    coachID INT,
    stadiumID INT,
    sponsorID INT,
    conferenceID INT,
    name VARCHAR(100),
    championships_won INT,
    playoffs_won INT,
    earnings FLOAT,
    PRIMARY KEY(teamID),
    FOREIGN KEY(coachID) REFERENCES coach(coachID),
    FOREIGN KEY(stadiumID) REFERENCES stadium(stadiumID),
    FOREIGN KEY(sponsorID) REFERENCES sponsor(sponsorID),
    FOREIGN KEY(conferenceID) REFERENCES conference(conferenceID)
);


CREATE TABLE referee (
    refereeID INT AUTO_INCREMENT,
    favoriteTeamID INT,
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    PRIMARY KEY(refereeID),
    FOREIGN KEY(favoriteTeamID) REFERENCES team(teamID)
);


CREATE TABLE player (
    playerID INT AUTO_INCREMENT,
    teamID INT,
    name VARCHAR(100),
    position VARCHAR(20),
    number INT,
    height int,
    age INT,
    salary float,
    PRIMARY KEY(playerID),
    FOREIGN KEY(teamID) REFERENCES team(teamID)
);


CREATE TABLE donation (
    donationID INT AUTO_INCREMENT,
    teamID INT NOT NULL,
    sponsorID INT NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);

CREATE TABLE playoff (
    playoffID INT AUTO_INCREMENT,
    bracketID INT,
    championID INT,
    MVP INT,
    PRIMARY KEY(playoffID),
    FOREIGN KEY(bracketID) REFERENCES bracket(bracketID),
    FOREIGN KEY(championID) REFERENCES team(teamID),
    FOREIGN KEY(MVP) REFERENCES player(playerID)
);


-- "match" is a reserved keyword
CREATE TABLE `match` (
    matchID INT AUTO_INCREMENT,
    homeTeamID INT,
    visitingTeamID INT,
    stadiumID INT,
    streamingID INT,
    refereeID INT,
    bracketID INT,
    homeScore INT,
    visitingScore INT,
    ticket_cost FLOAT,
    date DATE,
    `round` INT DEFAULT NULL,
    PRIMARY KEY(matchID),
    FOREIGN KEY(homeTeamID) REFERENCES team(teamID),
    FOREIGN KEY(visitingTeamID) REFERENCES team(teamID),
    FOREIGN KEY(stadiumID) REFERENCES stadium(stadiumID),
    FOREIGN KEY(refereeID) REFERENCES referee(refereeID),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    FOREIGN KEY(bracketID) REFERENCES bracket(bracketID)
);


CREATE TABLE user (
    u_id INT AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE,
    password VARCHAR(255),
    PRIMARY KEY(u_id)
);


CREATE TABLE rating (
    score INT,
    u_id INT,
    streamingID INT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(u_id, streamingID)
);

CREATE TABLE ratingAuditLog (
    auditNum INT NOT NULL AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    Type VARCHAR(10),
    u_id INT,
    streamingID INT,
    score FLOAT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(auditNum)
);

COMMIT;

-- -------------------------

INSERT INTO coach VALUES 
(1, 'Michael Malone', 52, '2015-06-15', NULL, 4),
(2, 'Jacque Vaughn', 49, '2022-11-01', NULL, 3.5),
(3, 'Brian Keefe', 46, '2024-01-25', NULL, 2.8),
(4, 'Steve Kerr', 58, '2014-05-19', NULL, 7.5),
(5, 'Will Hardy', 36, '2022-06-29', NULL, 3.2),
(6, 'Gregg Popovich', 75, '1996-12-10', NULL, 11),
(7, 'Mike Brown', 54, '2022-05-09', NULL, 4.5),
(8, 'Erik Spoelstra', 53, '2008-04-28', NULL, 8.5),
(9, 'J.B. Bickerstaff', 45, '2021-03-10', NULL, 3.8),
(10, 'Tom Thibodeau', 67, '2020-07-30', NULL, 6.5),
(11, 'Phil Jackson', 78, '1989-07-10', '2011-05-08', 12),
(12, 'Pat Riley', 79, '1981-11-19', '2008-04-16', 9.5),
(13, 'Red Auerbach', 89, '1950-05-15', '1966-04-28', 0.8),
(14, 'Jerry Sloan', 78, '1988-12-09', '2011-02-10', 5.2),
(15, 'Don Nelson', 84, '1976-10-14', '2010-04-14', 6.1);


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


INSERT INTO streaming_service VALUES
(1, 'DIRECTV Stream', 79.99, 0, 0, 'https://www.directv.com/sports/nba-basketball/'),
(2, 'Hulu', 7.99, 0, 0, 'https://www.hulu.com/nba'),
(3, 'NBA TV', 6.99, 0, 0, 'https://www.nba.com/league-pass-purchase'),
(4, 'Sling TV', 61.00, 0, 0, 'https://www.sling.com/sports/basketball'),
(5, 'YouTube TV', 82.99, 0, 0, 'https://tv.youtube.com/welcome/?utm_servlet=prod&rd_rsn=asi&zipcode=11432'),
(6, 'ESPN+', 10.99, 0, 0, 'https://www.espn.com/espnplus/'),
(7, 'Fubo', 74.99, 0, 0, 'https://www.fubo.tv/stream/nba/'),
(8, 'NBA League Pass', 14.99, 0, 0, 'https://www.tntdrama.com/nba-on-tnt'),
(9, 'Max', 16.99, 0, 0, 'https://www.max.com/sports/nba'),
(10, 'Amazon Prime', 14.99, 0, 0, 'https://www.amazon.com/b?ie=UTF8&node=17933054011');

INSERT INTO bracket VALUES
(1, 8, 'Play-Offs 2022'),
(2, 16, 'Play-Offs 2024'),
(3, 8, 'Play-Offs 2023'),
(4, 8, 'Play-In 2024'),
(5, 8, 'Play-Offs 2023'),
(6, 16, 'Play-In 2023'),
(7, 16, 'Play-In 2020'),
(8, 16, 'Play-In 2024'),
(9, 16, 'Play-Offs 2021'),
(10, 16, 'Play-In 2020');

INSERT INTO team VALUES
(1, 1, 1, 3, 2, 'Denver Nuggets', 1, 3, 350),
(2, 2, 2, 1, 1, 'Brooklyn Nets', 0, 1, 310),
(3, 3, 3, 5, 1, 'Washington Wizards', 1, 4, 320),
(4, 4, 4, 9, 2, 'Golden State Warriors', 7, 12, 510),
(5, 5, 5, 8, 2, 'Utah Jazz', 0, 2, 340),
(6, 6, 6, 4, 2, 'San Antonio Spurs', 5, 10, 390),
(7, 7, 7, 10, 2, 'Sacramento Kings', 0, 1, 300),
(8, 8, 8, 2, 1, 'Miami Heat', 3, 9, 380),
(9, 9, 9, 6, 1, 'Detroit Pistons', 3, 5, 290),
(10, 10, 10, 7, 1, 'New York Knicks', 2, 8, 425),

(11, 1, 2, 3, 1, 'Boston Celtics', 17, 22, 525),
(12, 2, 3, 4, 1, 'Philadelphia 76ers', 3, 9, 430),
(13, 3, 4, 5, 1, 'Milwaukee Bucks', 2, 7, 415),
(14, 4, 5, 6, 1, 'Chicago Bulls', 6, 11, 450),
(15, 5, 6, 7, 1, 'Cleveland Cavaliers', 1, 5, 400),
(16, 6, 7, 8, 2, 'Phoenix Suns', 0, 4, 385),
(17, 7, 8, 9, 2, 'Dallas Mavericks', 1, 6, 395),
(18, 8, 9, 10, 2, 'Los Angeles Lakers', 17, 32, 550),
(19, 9, 10, 1, 2, 'LA Clippers', 0, 8, 375),
(20, 10, 1, 2, 2, 'Oklahoma City Thunder', 0, 5, 360);

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


INSERT INTO player VALUES
(1, 1, 'Nikola Jokic', 'C', 15, 83, 29, 47.6),
(2, 2, 'Mikal Bridges', 'SF', 1, 78, 27, 23.3),
(3, 3, 'Jordan Poole', 'SG', 13, 76, 24, 27.5),
(4, 4, 'Stephen Curry', 'PG', 30, 74, 36, 51.9),
(5, 5, 'Lauri Markkanen', 'PF', 23, 84, 27, 18.0),
(6, 6, 'Victor Wembanyama', 'PF', 1, 88, 20, 12.5),
(7, 7, 'DeAaron Fox', 'PG', 5, 75, 26, 32.6),
(8, 8, 'Jimmy Butler', 'SF', 22, 79, 34, 45.2),
(9, 9, 'Cade Cunningham', 'PG', 2, 78, 22, 11.06),
(10, 10, 'Jalen Brunson', 'PG', 11, 74, 27, 26.35),
(11, 1, 'Christian Braun', 'SG', 0, 79, 23, 2.94),
(12, 2, 'Michael Jordan', 'SG', 23, 78, 60, 33.14),
(13, 6, 'Kobe Bryant', 'SG', 24, 78, 41, 25.0),
(14, 8, 'Dwyane Wade', 'SG', 3, 76, 42, 20.0),
(15, 10, 'Patrick Ewing', 'C', 33, 84, 62, 18.72),
(16, 2, 'Magic Johnson', 'PG', 32, 81, 64, 14.66),
(17, 4, 'Wilt Chamberlain', 'C', 13, 85, 63, 10.0),
(18, 3, 'Larry Bird', 'SF', 33, 81, 67, 7.07),
(19, 5, 'John Stockton', 'PG', 12, 73, 62, 6.0),
(20, 9, 'Bill Russell', 'C', 6, 82, 89, 0.1);


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


INSERT INTO `match` 
(matchID, homeTeamID, visitingTeamID, stadiumID, streamingID, refereeID, bracketID, homeScore, visitingScore, ticket_cost, date) 
VALUES
-- Bracket 1
(1, 19, 17, 3, 2, 2, 1, 101, 99, 89.25, '2022-05-01'),
(2, 11, 6, 6, 3, 4, 1, 115, 107, 92.10, '2022-05-01'),
(3, 15, 14, 1, 1, 1, 1, 97, 103, 87.50, '2022-05-01'),
(4, 18, 5, 3, 3, 4, 1, 122, 118, 90.35, '2022-05-01'),
(5, 19, 11, 1, 3, 4, 1, 110, 98, 85.90, '2022-05-05'),
(6, 14, 18, 10, 5, 3, 1, 95, 102, 93.75, '2022-05-05'),
(7, 19, 18, 2, 5, 4, 1, 119, 124, 88.60, '2022-05-09'),

-- Bracket 2
(8, 9, 11, 9, 1, 1, 2, 104, 97, 88.45, '2024-05-01'),
(9, 18, 7, 3, 3, 4, 2, 121, 116, 91.20, '2024-05-01'),
(10, 3, 14, 6, 5, 5, 2, 98, 101, 86.75, '2024-05-01'),
(11, 20, 5, 6, 3, 1, 2, 113, 110, 92.90, '2024-05-01'),
(12, 16, 17, 2, 1, 2, 2, 125, 119, 90.50, '2024-05-01'),
(13, 4, 1, 6, 3, 4, 2, 96, 109, 85.60, '2024-05-01'),
(14, 2, 6, 10, 3, 1, 2, 100, 98, 93.40, '2024-05-01'),
(15, 12, 13, 8, 4, 5, 2, 118, 106, 89.75, '2024-05-01'),
(16, 9, 18, 9, 3, 2, 2, 107, 95, 91.10, '2024-05-05'),
(17, 14, 20, 1, 3, 3, 2, 112, 123, 87.85, '2024-05-05'),
(18, 16, 1, 3, 4, 4, 2, 120, 98, 89.30, '2024-05-05'),
(19, 2, 12, 8, 5, 4, 2, 102, 99, 92.25, '2024-05-05'),
(20, 9, 20, 9, 1, 2, 2, 108, 124, 86.90, '2024-05-09'),
(21, 16, 2, 9, 5, 5, 2, 115, 111, 94.00, '2024-05-09'),
(22, 20, 16, 6, 4, 1, 2, 117, 105, 88.80, '2024-05-13'),

-- Bracket 3
(23, 18, 12, 7, 2, 5, 3, 105, 102, 89.90, '2023-05-01'),
(24, 3, 8, 8, 2, 2, 3, 110, 99, 94.20, '2023-05-01'),
(25, 5, 15, 2, 5, 4, 3, 122, 115, 87.80, '2023-05-01'),
(26, 16, 10, 3, 1, 4, 3, 97, 124, 91.50, '2023-05-01'),
(27, 18, 3, 5, 4, 1, 3, 101, 98, 85.75, '2023-05-05'),
(28, 5, 10, 3, 2, 4, 3, 115, 103, 92.60, '2023-05-05'),
(29, 18, 5, 10, 2, 3, 3, 124, 109, 88.20, '2023-05-09'),

-- Bracket 4
(30, 12, 6, 7, 3, 1, 4, 98, 112, 90.40, '2024-05-01'),
(31, 13, 16, 1, 4, 2, 4, 120, 102, 85.85, '2024-05-01'),
(32, 1, 17, 8, 1, 1, 4, 110, 117, 87.95, '2024-05-01'),
(33, 14, 3, 7, 4, 2, 4, 123, 114, 89.10, '2024-05-01'),
(34, 6, 13, 9, 1, 5, 4, 115, 101, 91.65, '2024-05-05'),
(35, 17, 14, 5, 5, 4, 4, 96, 95, 94.25, '2024-05-05'),
(36, 6, 17, 6, 5, 3, 4, 105, 99, 88.90, '2024-05-09'),

-- Bracket 5
(37, 1, 7, 2, 5, 4, 5, 101, 96, 88.55, '2023-05-01'),
(38, 9, 17, 4, 4, 5, 5, 108, 112, 91.30, '2023-05-01'),
(39, 2, 16, 8, 5, 3, 5, 117, 104, 86.95, '2023-05-01'),
(40, 5, 8, 6, 5, 4, 5, 122, 115, 93.45, '2023-05-01'),
(41, 1, 17, 9, 3, 1, 5, 111, 95, 87.80, '2023-05-05'),
(42, 2, 5, 9, 4, 3, 5, 103, 99, 90.10, '2023-05-05'),
(43, 1, 2, 2, 5, 3, 5, 119, 124, 89.70, '2023-05-09'),

-- Bracket 6
(44, 5, 7, 1, 5, 2, 6, 118, 107, 91.35, '2023-05-01'),
(45, 14, 16, 5, 1, 4, 6, 125, 114, 89.20, '2023-05-01'),
(46, 13, 9, 8, 1, 2, 6, 99, 112, 86.90, '2023-05-01'),
(47, 4, 17, 7, 1, 2, 6, 105, 96, 93.60, '2023-05-01'),
(48, 1, 11, 5, 1, 1, 6, 108, 103, 88.75, '2023-05-01'),
(49, 18, 19, 7, 4, 4, 6, 116, 102, 90.95, '2023-05-01'),
(50, 12, 3, 6, 1, 3, 6, 120, 118, 87.30, '2023-05-01'),
(51, 20, 6, 5, 5, 4, 6, 110, 95, 92.80, '2023-05-01'),
(52, 5, 14, 1, 1, 3, 6, 100, 117, 85.90, '2023-05-05'),
(53, 9, 4, 6, 5, 3, 6, 122, 119, 93.25, '2023-05-05'),
(54, 1, 18, 9, 2, 1, 6, 115, 98, 88.15, '2023-05-05'),
(55, 12, 20, 4, 1, 1, 6, 105, 108, 90.45, '2023-05-05'),
(56, 14, 9, 4, 2, 1, 6, 109, 95, 89.80, '2023-05-09'),
(57, 1, 20, 2, 3, 3, 6, 97, 103, 85.65, '2023-05-09'),
(58, 14, 20, 4, 4, 2, 6, 121, 113, 87.95, '2023-05-13'),

-- Bracket 7
(59, 9, 4, 5, 1, 1, 7, 110, 97, 91.45, '2020-05-01'),
(60, 15, 20, 6, 4, 3, 7, 103, 117, 88.90, '2020-05-01'),
(61, 18, 11, 5, 2, 2, 7, 125, 101, 92.75, '2020-05-01'),
(62, 17, 10, 1, 2, 3, 7, 113, 105, 85.80, '2020-05-01'),
(63, 1, 12, 7, 2, 1, 7, 116, 109, 90.10, '2020-05-01'),
(64, 6, 8, 8, 5, 2, 7, 102, 99, 86.70, '2020-05-01'),
(65, 16, 3, 4, 2, 4, 7, 108, 95, 88.30, '2020-05-01'),
(66, 13, 2, 8, 3, 3, 7, 120, 97, 93.40, '2020-05-01'),
(67, 9, 20, 8, 2, 5, 7, 112, 120, 89.60, '2020-05-05'),
(68, 18, 17, 6, 5, 3, 7, 118, 104, 92.10, '2020-05-05'),
(69, 1, 6, 4, 5, 1, 7, 119, 106, 85.95, '2020-05-05'),
(70, 16, 13, 8, 4, 2, 7, 101, 114, 87.20, '2020-05-05'),
(71, 20, 18, 7, 2, 2, 7, 115, 108, 90.55, '2020-05-09'),
(72, 1, 13, 3, 5, 2, 7, 124, 98, 93.00, '2020-05-09'),
(73, 20, 1, 10, 1, 1, 7, 109, 123, 88.15, '2020-05-13'),

-- Bracket 8
(74, 14, 8, 9, 5, 3, 8, 110, 101, 89.75, '2024-05-01'),
(75, 15, 6, 1, 3, 1, 8, 103, 117, 87.10, '2024-05-01'),
(76, 11, 1, 8, 4, 3, 8, 98, 122, 91.55, '2024-05-01'),
(77, 20, 12, 3, 3, 3, 8, 125, 113, 90.20, '2024-05-01'),
(78, 2, 9, 4, 3, 5, 8, 105, 99, 86.40, '2024-05-01'),
(79, 5, 10, 8, 5, 5, 8, 115, 107, 88.85, '2024-05-01'),
(80, 13, 7, 5, 4, 4, 8, 112, 104, 92.70, '2024-05-01'),
(81, 17, 3, 9, 1, 3, 8, 118, 97, 90.35, '2024-05-01'),
(82, 14, 6, 3, 1, 1, 8, 122, 116, 91.05, '2024-05-05'),
(83, 1, 20, 8, 4, 3, 8, 99, 108, 85.95, '2024-05-05'),
(84, 2, 5, 9, 2, 4, 8, 101, 113, 87.50, '2024-05-05'),
(85, 13, 17, 10, 5, 2, 8, 117, 106, 89.60, '2024-05-05'),
(86, 14, 20, 9, 5, 1, 8, 109, 114, 88.10, '2024-05-09'),
(87, 5, 13, 9, 5, 2, 8, 97, 118, 93.15, '2024-05-09'),
(88, 20, 13, 3, 1, 1, 8, 124, 110, 92.20, '2024-05-13'),

-- Bracket 9
(89, 11, 2, 2, 3, 4, 9, 105, 96, 91.25, '2021-05-01'),
(90, 9, 14, 7, 1, 5, 9, 112, 103, 89.30, '2021-05-01'),
(91, 6, 8, 5, 5, 3, 9, 117, 95, 87.60, '2021-05-01'),
(92, 17, 12, 8, 3, 1, 9, 118, 107, 93.50, '2021-05-01'),
(93, 3, 15, 10, 3, 4, 9, 99, 120, 85.95, '2021-05-01'),
(94, 20, 13, 4, 2, 1, 9, 115, 104, 90.65, '2021-05-01'),
(95, 19, 16, 2, 2, 3, 9, 121, 106, 86.85, '2021-05-01'),
(96, 7, 1, 2, 4, 1, 9, 97, 111, 88.90, '2021-05-01'),
(97, 11, 9, 10, 1, 5, 9, 109, 114, 92.40, '2021-05-05'),
(98, 6, 17, 5, 4, 3, 9, 102, 116, 91.10, '2021-05-05'),
(99, 15, 20, 4, 5, 4, 9, 120, 105, 90.20, '2021-05-05'),
(100, 19, 1, 9, 3, 3, 9, 117, 108, 89.45, '2021-05-05'),
(101, 9, 17, 1, 1, 2, 9, 108, 102, 88.15, '2021-05-09'),
(102, 15, 19, 9, 5, 4, 9, 124, 112, 87.90, '2021-05-09'),
(103, 9, 15, 2, 5, 4, 9, 115, 118, 93.00, '2021-05-13'),

-- Bracket 10
(104, 15, 7, 7, 2, 4, 10, 113, 97, 88.30, '2020-05-01'),
(105, 3, 6, 7, 5, 3, 10, 105, 119, 91.45, '2020-05-01'),
(106, 9, 4, 7, 2, 4, 10, 101, 112, 85.95, '2020-05-01'),
(107, 8, 12, 5, 5, 3, 10, 98, 121, 89.70, '2020-05-01'),
(108, 20, 5, 10, 5, 4, 10, 117, 103, 90.10, '2020-05-01'),
(109, 16, 14, 8, 5, 2, 10, 106, 124, 92.85, '2020-05-01'),
(110, 17, 2, 3, 2, 1, 10, 109, 95, 87.60, '2020-05-01'),
(111, 1, 19, 2, 4, 2, 10, 118, 101, 88.80, '2020-05-01'),
(112, 15, 6, 4, 3, 3, 10, 110, 104, 90.25, '2020-05-05'),
(113, 4, 12, 2, 3, 5, 10, 107, 97, 89.90, '2020-05-05'),
(114, 20, 14, 4, 3, 3, 10, 116, 102, 92.10, '2020-05-05'),
(115, 17, 1, 4, 1, 5, 10, 119, 98, 86.75, '2020-05-05'),
(116, 15, 4, 4, 2, 5, 10, 120, 106, 87.45, '2020-05-09'),
(117, 20, 17, 6, 2, 5, 10, 109, 112, 91.95, '2020-05-09'),
(118, 15, 20, 4, 4, 2, 10, 122, 115, 93.50, '2020-05-13');


COMMIT;
DROP PROCEDURE IF EXISTS GetPlayerByName;
CREATE PROCEDURE GetPlayerByName(IN player_name VARCHAR(100))
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID
  WHERE p.Name LIKE CONCAT('%', player_name, '%'); 
END;

COMMIT;