SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `ratingAuditLog`;
DROP TABLE IF EXISTS `rating`;
-- DROP TABLE IF EXISTS `user`;
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
    picLink VARCHAR(255),
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


-- CREATE TABLE user (
--     u_id INT AUTO_INCREMENT,
--     username VARCHAR(25) UNIQUE,
--     password VARCHAR(255),
--     PRIMARY KEY(u_id)
-- );


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

INSERT INTO player (teamID, name, position, number, height, age, salary, picLink) VALUES
(1, 'Jamal Murray', 'Point Guard', 27, 76, 27, 33.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627750.png'),
(1, 'Christian Braun', 'Shooting Guard', 0, 80, 23, 3.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631128.png'),
(1, 'Michael Porter Jr.', 'Small Forward', 1, 82, 25, 35.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629008.png'),
(1, 'Aaron Gordon', 'Power Forward', 50, 80, 28, 22.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203932.png'),
(1, 'Nikola Jokic', 'Center', 15, 83, 29, 46.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203999.png'),

(2, 'Keon Johnson', 'Point Guard', 45, 76, 22, 2.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630553.png'),
(2, 'Cam Thomas', 'Shooting Guard', 24, 75, 23, 2.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630560.png'),
(2, 'Jalen Wilson', 'Small Forward', 22, 80, 23, 1.7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630592.png'),
(2, 'Trendon Watford', 'Power Forward', 2, 81, 24, 2.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630570.png'),
(2, 'Nic Claxton', 'Center', 33, 83, 25, 10.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629651.png'),

(3, 'Jordan Poole', 'Point Guard', 13, 76, 24, 30, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629673.png'),
(3, 'Bub Carrington', 'Shooting Guard', 8, 76, 19, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1642267.png'),
(3, 'Bilal Coulibaly', 'Small Forward', 0, 78, 19, 6.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1641731.png'),
(3, 'Tristan Vukcevic', 'Power Forward', 0, 83, 21, 2.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1641774.png'),
(3, 'Sadiq Bey', 'Center', 14, 79, 25, 5.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630180.png'),

(4, 'Stephen Curry', 'Point Guard', 30, 74, 36, 51.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201939.png'),
(4, 'Moses Moody', 'Shooting Guard', 4, 77, 21, 3.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630541.png'),
(4, 'Jonathan Kuminga', 'Small Forward', 0, 80, 21, 6.0, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630228.png'),
(4, 'Draymond Green', 'Power Forward', 23, 78, 34, 24.1, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203110.png'),
(4, 'Quinten Post', 'Center', 21, 84, 24, 1.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1642366.png'),

(5, 'Keyonte George', 'Point Guard', 3, 76, 20, 3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1641718.png'),
(5, 'Jordan Clarkson', 'Shooting Guard', 00, 76, 31, 14, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203903.png'),
(5, 'Lauri Markkanen', 'Small Forward', 23, 84, 27, 17.3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628374.png'),
(5, 'John Collins', 'Power Forward', 20, 81, 26, 26.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628381.png'),
(5, 'Walker Kessler', 'Center', 24, 84, 22, 2.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631117.png'),

(6, 'Chris Paul', 'Point Guard', 3, 72, 39, 30, 'https://cdn.nba.com/headshots/nba/latest/1040x760/101108.png'),
(6, 'Devin Vassell', 'Shooting Guard', 24, 77, 23, 27, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630170.png'),
(6, 'Keldon Johnson', 'Small Forward', 0, 78, 24, 20, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629640.png'),
(6, 'Jeremy Sochan', 'Power Forward', 10, 80, 20, 5.4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631110.png'),
(6, 'Victor Wembanyama', 'Center', 1, 88, 20, 12.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1641705.png'),

(7, 'Markelle Fultz', 'Point Guard', 20, 76, 25, 17, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628365.png'),
(7, 'Malik Monk', 'Shooting Guard', 0, 74, 26, 9.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628370.png'),
(7, 'Keegan Murray', 'Small Forward', 13, 80, 23, 8.4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631099.png'),
(7, 'Trey Lyles', 'Power Forward', 41, 81, 28, 8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626168.png'),
(7, 'Jonas Valanciunas', 'Center', 17, 84, 32, 15, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202685.png'),

(8, 'Terry Rozier III', 'Point Guard', 2, 73, 30, 24, 'https://cdn.nba.com/teams/static/heat/images/roster/2425/600_trozier.jpg?imwidth=1920'),
(8, 'Tyler Herro', 'Shooting Guard', 14, 77, 24, 27, 'https://cdn.nba.com/teams/static/heat/images/roster/2425/600_therro.jpg?imwidth=1920'),
(8, 'Jaime Jaquez Jr.', 'Small Forward', 11, 78, 23, 3.5, 'https://cdn.nba.com/teams/static/heat/images/roster/2425/600_jjaquez.jpg?imwidth=1920'),
(8, 'Kevin Love', 'Power Forward', 42, 80, 35, 3.8, 'https://cdn.nba.com/teams/static/heat/images/roster/2425/600_klove.jpg?imwidth=1920'),
(8, 'Bam Adebayo', 'Center', 13, 81, 26, 34.8, 'https://cdn.nba.com/teams/static/heat/images/roster/2425/600_badebayo.jpg?imwidth=1920'),

(9, 'Cade Cunningham', 'Point Guard', 2, 79, 22, 13.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630595.png'),
(9, 'Malik Beasley', 'Shooting Guard', 5, 76, 27, 2.7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627736.png'),
(9, 'Tim Hardaway Jr.', 'Small Forward', 8, 77, 32, 16.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203501.png'),
(9, 'Tobias Harris', 'Power Forward', 12, 81, 31, 16, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202699.png'),
(9, 'Jalen Duren', 'Center', 0, 82, 20, 4.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631105.png'),

(10, 'Jalen Brunson', 'Point Guard', 11, 74, 27, 26, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628973.png'),
(10, 'Mikal Bridges', 'Shooting Guard', 25, 78, 27, 23.3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628969.png'),
(10, 'Josh Hart', 'Small Forward', 3, 77, 29, 18, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628404.png'),
(10, 'Karl-Anthony Towns', 'Power Forward', 32, 83, 28, 36, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626157.png'),
(10, 'Mitchell Robinson', 'Center', 23, 84, 26, 15.7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629011.png'),

(11, 'Jrue Holiday', 'Point Guard', 4, 76, 33, 34.9, 'https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/201950.png?111'),
(11, 'Derrick White', 'Shooting Guard', 9, 76, 29, 18, 'https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/1628401.png?111'),
(11, 'Jayson Tatum', 'Small Forward', 0, 80, 26, 32.6, 'https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/1628369.png?111'),
(11, 'Kristaps Porzingis', 'Power Forward', 8, 86, 28, 30.1, 'https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/204001.png?111'),
(11, 'Al Horford', 'Center', 42, 81, 37, 10, 'https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/201143.png?111'),

(12, 'Tyrese Maxey', 'Point Guard', 0, 74, 23, 34.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630178.png'),
(12, 'Quentin Grimes', 'Shooting Guard', 5, 77, 24, 4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629656.png'),
(12, 'Paul George', 'Small Forward', 8, 80, 34, 30, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/4251.png'),
(12, 'Kelly Oubre Jr.', 'Power Forward', 9, 79, 28, 9, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3133603.png&w=350&h=254'),
(12, 'Andre Drummond', 'Center', 1, 82, 30, 3.3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203083.png'), 

(13, 'Damian Lillard', 'Point Guard', 0, 74, 33, 45.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203081.png'),
(13, 'Gary Trent Jr.', 'Shooting Guard', 5, 77, 25, 18.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629018.png'),
(13, 'Kyle Kuzma', 'Small Forward', 18, 81, 28, 25, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628398.png'),
(13, 'Giannis Antetokounmpo', 'Power Forward', 34, 83, 30, 48, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203507.png'),
(13, 'Brook Lopez', 'Center', 11, 84, 36, 23, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201572.png'),

(14, 'Coby White', 'Point Guard', 0, 77, 24, 12.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629632.png'),
(14, 'Kevin Huerter', 'Shooting Guard', 13, 79, 25, 16.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628989.png'),
(14, 'Patrick Williams', 'Small Forward', 44, 80, 22, 7.7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630172.png'),
(14, 'Julian Phillips', 'Power Forward', 15, 79, 20, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1641763.png'),
(14, 'Nikola Vucevic', 'Center', 9, 83, 33, 18, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202696.png'),

(15, 'Darius Garland', 'Point Guard', 10, 73, 24, 36.7, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629636.png'),
(15, 'Donovan Mitchell', 'Shooting Guard', 45, 74, 27, 34.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628378.png'),
(15, 'Isaac Okoro', 'Small Forward', 35, 77, 23, 8.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630171.png'),
(15, 'Evan Mobley', 'Power Forward', 4, 83, 23, 11.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630596.png'),
(15, 'Jarrett Allen', 'Center', 31, 82, 26, 20, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628386.png'),

(16, 'Devin Booker', 'Point Guard', 1, 77, 27, 36, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626164.png'),
(16, 'Bradley Beal', 'Shooting Guard', 3, 76, 30, 50.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203078.png'),
(16, 'Kevin Durant', 'Small Forward', 35, 82, 35, 47.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201142.png'),
(16, 'Royce O Neale', 'Power Forward', 00, 78, 31, 9.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626220.png'),
(16, 'Mason Plumlee', 'Center', 22, 83, 34, 5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/203486.png'),

(17, 'Kyrie Irving', 'Point Guard', 11, 74, 33, 41, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/6442.png&h=80&w=110&scale=crop'),
(17, 'Klay Thompson', 'Shooting Guard', 31, 77, 35, 15.9, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/6475.png&h=80&w=110&scale=crop'),
(17, 'Caleb Martin', 'Small Forward', 16, 77, 29, 8.1, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/3138160.png&h=80&w=110&scale=crop'),
(17, 'Anthony Davis', 'Power Forward', 3, 82, 32, 43.2, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/6583.png&h=80&w=110&scale=crop'),
(17, 'Daniel Gafford', 'Center', 21, 82, 26, 13.4, 'https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/4278049.png&h=80&w=110&scale=crop'),

(18, 'Gabe Vincent', 'Point Guard', 7, 74, 28, 11, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629216.png'),
(18, 'Austin Reaves', 'Shooting Guard', 15, 77, 26, 13.5, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1630559.png'),
(18, 'LeBron James', 'Small Forward', 23, 81, 39, 51.4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/2544.png'),
(18, 'Rui Hachimura', 'Power Forward', 28, 80, 26, 17, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629060.png'),
(18, 'Christian Koloko', 'Center', 10, 84, 24, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631132.png'),

(19, 'James Harden', 'Point Guard', 1, 77, 34, 35.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201935.png'),
(19, 'Norman Powell', 'Shooting Guard', 24, 76, 30, 18, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1626181.png'),
(19, 'Kawhi Leonard', 'Small Forward', 2, 79, 32, 45.6, 'https://cdn.nba.com/headshots/nba/latest/1040x760/202695.png'),
(19, 'Nicolas Batum', 'Power Forward', 33, 80, 35, 10.8, 'https://cdn.nba.com/headshots/nba/latest/1040x760/201587.png'),
(19, 'Ivica Zubac', 'Center', 40, 84, 27, 11, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1627826.png'),

(20, 'Shai Gilgeous-Alexander', 'Point Guard', 2, 78, 25, 33.4, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1628983.png'),
(20, 'Luguentz Dort', 'Shooting Guard', 5, 76, 25, 15.3, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629652.png'),
(20, 'Kenrich Williams', 'Small Forward', 34, 78, 29, 6.2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1629026.png'),
(20, 'Jaylin Williams', 'Power Forward', 6, 78, 22, 2, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631119.png'),
(20, 'Chet Holmgren', 'Center', 7, 84, 22, 10.9, 'https://cdn.nba.com/headshots/nba/latest/1040x760/1631096.png');


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
DELIMITER $$
CREATE PROCEDURE GetPlayerByName(IN player_name VARCHAR(100))
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM player p
  INNER JOIN team t on p.teamID = t.teamID
  WHERE p.Name LIKE CONCAT('%', player_name, '%'); 
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetPlayerByTeam;
DELIMITER $$
CREATE PROCEDURE GetPlayerByTeam(IN team_name VARCHAR(100))
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM player p
  INNER JOIN team t on p.teamID = t.teamID
  WHERE t.Name LIKE CONCAT('%', team_name, '%');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetPlayerByPosition;
DELIMITER $$
CREATE PROCEDURE GetPlayerByPosition(IN position_name VARCHAR(100))
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM player p
  INNER JOIN team t on p.teamID = t.teamID
  WHERE p.Position LIKE CONCAT('%', position_name, '%'); 
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetAllPlayers;
DELIMITER $$
CREATE PROCEDURE GetAllPlayers()
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.height, p.age, p.salary, t.name as team_name
  FROM player p
  INNER JOIN team t on p.teamID = t.teamID;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetTeamsInConference;
DELIMITER $$
CREATE PROCEDURE GetTeamsInConference(IN conference_name VARCHAR(100))
BEGIN
  SELECT 
    t.teamID, t.Name, t.Championships_Won, t.playoffs_won, t.earnings, 
    c.side AS ConferenceSide
  FROM team t
  INNER JOIN conference c ON t.conferenceID = c.conferenceID
  WHERE c.side LIKE CONCAT('%', conference_name, '%');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetTeamInfo;
DELIMITER $$
CREATE PROCEDURE GetTeamInfo(IN team_name VARCHAR(100))
BEGIN
  SELECT
    t.TeamID, t.Name AS TeamName, t.Championships_Won, t.Playoffs_Won, t.Earnings,
    c.Name AS CoachName,
    s.Name AS StadiumName, s.Location AS StadiumLocation, s.Capacity AS StadiumCapacity,
    sp.Name AS SponsorName, sp.Money AS SponsorMoney,
    co.Side AS ConferenceSide
  FROM Team t
  INNER JOIN coach c ON t.coachID = c.coachID
  INNER JOIN stadium s ON t.stadiumID = s.stadiumID
  INNER JOIN sponsor sp ON t.sponsorID = sp.sponsorID
  INNER JOIN conference co ON t.conferenceID = co.conferenceID
  WHERE t.Name LIKE CONCAT('%', team_name, '%');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetMatchInfoByDate;
DELIMITER $$
CREATE PROCEDURE GetMatchInfoByDate(IN match_date DATE)
BEGIN
  SELECT 
    m.score, m.Ticket_Cost, m.Date, 
    t1.Name AS HomeTeamName, 
    t2.Name AS VisitingTeamName, 
    s.Name AS StadiumName, 
    r.Name AS RefereeName, 
    ss.Name AS StreamingService
  FROM `match` m
  INNER JOIN team t1 ON m.HomeTeamID = t1.teamID
  INNER JOIN team t2 ON m.VisitingTeamID = t2.teamID
  INNER JOIN stadium s ON m.stadiumID = s.stadiumID
  INNER JOIN referee r ON m.refereeID = r.refereeID
  INNER JOIN streaming_Service ss ON m.streamingID = ss.streamingID
  WHERE m.Date = match_date;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetMatchInfoByTeam;
DELIMITER $$
CREATE PROCEDURE GetMatchInfoByTeam(IN team_name VARCHAR(100))
BEGIN
  SELECT 
    m.score, m.Ticket_Cost, m.Date, 
    t1.Name AS HomeTeamName, 
    t2.Name AS VisitingTeamName, 
    s.Name AS StadiumName, 
    r.Name AS RefereeName, 
    ss.Name AS StreamingService
  FROM `match` m
  INNER JOIN team t1 ON m.HomeTeamID = t1.teamID
  INNER JOIN team t2 ON m.VisitingTeamID = t2.teamID
  INNER JOIN stadium s ON m.stadiumID = s.stadiumID
  INNER JOIN referee r ON m.refereeID = r.refereeID
  INNER JOIN streaming_service ss ON m.streamingID = ss.streamingID
  WHERE t1.name LIKE CONCAT('%', team_name, '%') OR t2.name LIKE CONCAT('%', team_name, '%');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS OrganizeBracketMatches;
DELIMITER $$
CREATE PROCEDURE OrganizeBracketMatches(IN in_bracketID INT)
BEGIN
    DECLARE matchCount INT;
    DECLARE totalRounds INT;
    DECLARE roundSize INT;
    DECLARE roundNumber INT DEFAULT 1;
    DECLARE matchIndex INT DEFAULT 0;
    DECLARE offset INT DEFAULT 0;

    SELECT COUNT(*) INTO matchCount
    FROM `match`
    WHERE bracketID = in_bracketID;
    SET totalRounds = LOG2(matchCount + 1);

    DROP TEMPORARY TABLE IF EXISTS temp_matches;
    CREATE TEMPORARY TABLE temp_matches (
        idx INT AUTO_INCREMENT PRIMARY KEY,
        matchID INT
    );

    INSERT INTO temp_matches (matchID)
    SELECT matchID
    FROM `match`
    WHERE bracketID = in_bracketID
    ORDER BY matchID;

    SET roundNumber = 1;
    SET offset = 0;

    WHILE roundNumber <= totalRounds DO
        SET roundSize = POWER(2, totalRounds - roundNumber);
        SET matchIndex = 0;

        WHILE matchIndex < roundSize DO
            UPDATE `match` AS m
            JOIN temp_matches tm ON m.matchID = tm.matchID
            SET m.round = roundNumber
            WHERE tm.idx = offset + matchIndex + 1;
            SET matchIndex = matchIndex + 1;
        END WHILE;

        SET offset = offset + roundSize;
        SET roundNumber = roundNumber + 1;
    END WHILE;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetBracketByTeam;
DELIMITER $$
CREATE PROCEDURE GetBracketByTeam(IN teamName VARCHAR(255))
BEGIN
    SELECT DISTINCT m.bracketID
    FROM `match` m
    JOIN team t1 ON m.homeTeamID = t1.teamID
    JOIN team t2 ON m.visitingTeamID = t2.teamID
    WHERE t1.name LIKE CONCAT('%', teamName, '%') OR t2.name LIKE CONCAT('%', teamName,'%');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS GetBracketBySeason;
DELIMITER $$
CREATE PROCEDURE GetBracketBySeason(IN season VARCHAR(255))
BEGIN
    SELECT DISTINCT b.bracketID
    FROM bracket b
    WHERE b.season LIKE CONCAT('%', season, '%');
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS countPlayersByTeam;
DELIMITER $$
CREATE FUNCTION countPlayersByTeam(inTeamID INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total
  FROM player p
  WHERE p.teamID = inTeamID;
  RETURN total;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS update_championships_won;
DELIMITER $$
CREATE TRIGGER update_championships_won
AFTER INSERT ON playoff
FOR EACH ROW
BEGIN
  UPDATE team
  SET Championships_Won = Championships_Won + 1
  WHERE TeamID = NEW.ChampionID;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS new_donation;
DELIMITER $$
CREATE TRIGGER new_donation
AFTER INSERT ON donation
FOR EACH ROW
BEGIN
  UPDATE sponsor
  SET money = money + NEW.amount
  WHERE sponsorID = NEW.sponsorID;
  UPDATE team 
  SET earnings = earnings + new.amount
  WHERE teamID = NEW.teamID;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS ratingAdded; 
DELIMITER $$
CREATE TRIGGER ratingAdded
AFTER INSERT ON rating
FOR EACH ROW 
BEGIN
    INSERT INTO ratingAuditLog (Date, Time, Type, score, u_id, streamingID) VALUES
    (CURRENT_DATE, CURRENT_TIMESTAMP, "INSERT", NEW.score, NEW.u_id, NEW.streamingID);

    UPDATE streaming_service 
    SET rating = (rating*numRatings + NEW.score)/(numRatings + 1),
    numRatings = numRatings + 1
    WHERE streamingID = NEW.streamingID;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS ratingUpdated;
DELIMITER $$
CREATE TRIGGER ratingUpdated 
AFTER UPDATE ON rating
FOR EACH ROW
BEGIN
  INSERT INTO ratingAuditLog (Date, Time, Type, score, u_id, streamingID) VALUES
  (CURRENT_DATE, CURRENT_TIMESTAMP, "UPDATE", NEW.score, NEW.u_id, NEW.streamingID);

  UPDATE streaming_service
  SET rating = ((rating * numRatings) - OLD.score + NEW.score)/numRatings
  WHERE streamingID = NEW.streamingID;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS ratingDeleted;
DELIMITER $$
CREATE TRIGGER ratingDeleted 
AFTER DELETE ON rating
FOR EACH ROW
BEGIN
  INSERT INTO ratingAuditLog (Date, Time, Type, u_id, streamingID) VALUES
  (CURRENT_DATE, CURRENT_TIMESTAMP, "DELETE", OLD.u_id, OLD.streamingID);
  
  UPDATE streaming_service
  SET rating = CASE 
    WHEN (numRatings - 1) = 0 THEN 0
    ELSE ((rating * numRatings) - OLD.score) / (numRatings - 1)
  END,
  numRatings = numRatings - 1
  WHERE streamingID = OLD.streamingID;

  UPDATE streaming_service 
  SET rating = 0
  WHERE numRatings = 0;
END$$
DELIMITER ;



-- User privileges
DROP ROLE IF EXISTS 'Suser';
CREATE ROLE 'Suser';

-- Views for public
DROP VIEW IF EXISTS playerPublic;
CREATE VIEW playerPublic AS 
SELECT name, position, number, height, age, salary
FROM railway.player;

DROP VIEW IF EXISTS teamPublic;
CREATE OR REPLACE VIEW teamPublic AS
SELECT name, championships_won, playoffs_won, earnings
FROM railway.team;

DROP VIEW IF EXISTS ratingPublic;
CREATE OR REPLACE VIEW ratingPublic AS
SELECT score
FROM railway.rating;
-- Granting said views
GRANT SELECT ON railway.playerPublic TO 'Suser';
GRANT SELECT ON railway.teamPublic TO 'Suser';
GRANT SELECT ON railway.ratingPublic TO 'Suser';
-- I don't believe we need these as of now because these aren't really searchable
-- uncomment if it breaks things in accessing said info, then comment the views out 
-- GRANT SELECT ON db4.match TO 'Suser';
-- GRANT SELECT ON db4.streaming_service TO 'Suser';
-- GRANT SELECT ON db4.bracket TO 'Suser';
-- GRANT SELECT ON db4.conference TO 'Suser';
-- GRANT SELECT ON db4.rating TO 'Suser';

GRANT INSERT, UPDATE, DELETE ON railway.rating TO 'Suser';
