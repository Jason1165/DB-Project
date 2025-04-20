CREATE TABLE coach (
    coachID NUMERIC(6),
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    salary float,
    PRIMARY KEY(coachID)
);


CREATE TABLE stadium (
    stadiumID NUMERIC(6),
    name VARCHAR(100),
    location VARCHAR(100),
    capacity INT,
    revenue INT,
    PRIMARY KEY(stadiumId)
);

CREATE TABLE sponsor (
    sponsorID NUMERIC(6),
    name VARCHAR(100),
    money FLOAT,
    PRIMARY KEY(sponsorID)
);

CREATE TABLE conference (
    conferenceID NUMERIC(6),
    side VARCHAR(100),
    PRIMARY KEY (conferenceID)
);


CREATE TABLE streaming_service (
    streamingID NUMERIC(6),
    name VARCHAR(100),
    price DECIMAL(5,2),
    rating FLOAT,
    numRatings INT,
    PRIMARY KEY (streamingID)
);

CREATE TABLE bracket (
    bracketID NUMERIC(6),
    numTeams INT,
    season VARCHAR(100),
    PRIMARY KEY (bracketID)
);

CREATE TABLE team (
    teamID NUMERIC(6),
    coachID NUMERIC(6),
    stadiumID NUMERIC(6),
    sponsorID NUMERIC(6),
    conferenceID NUMERIC(6),
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
    refereeID NUMERIC(6),
    favoriteTeamID NUMERIC(6),
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    PRIMARY KEY(refereeID),
    FOREIGN KEY(favoriteTeamID) REFERENCES team(teamID)
);


CREATE TABLE player (
    playerID NUMERIC(6),
    teamID NUMERIC(6),
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
    donationID NUMERIC(6),
    teamID NUMERIC(6) NOT NULL,
    sponsorID NUMERIC(6) NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);

CREATE TABLE playoff (
    playoffID NUMERIC(6),
    bracketID NUMERIC(6),
    championID NUMERIC(6),
    MVP NUMERIC(6),
    PRIMARY KEY(playoffID),
    FOREIGN KEY(bracketID) REFERENCES bracket(bracketID),
    FOREIGN KEY(championID) REFERENCES team(teamID),
    FOREIGN KEY(MVP) REFERENCES player(playerID)
);


-- "match" is a reserved keyword
CREATE TABLE `match` (
    matchID NUMERIC(6),
    homeTeamID NUMERIC(6),
    visitingTeamID NUMERIC(6),
    stadiumID NUMERIC(6),
    streamingID NUMERIC(6),
    refereeID NUMERIC(6),
    bracketID NUMERIC(6),
    score VARCHAR(15),
    ticket_cost FLOAT,
    date DATE,
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
    rid INT AUTO_INCREMENT,
    score FLOAT,
    u_id INT,
    streamingID NUMERIC(6),
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(rid)
);

CREATE TABLE ratingAuditLog (
    auditNum INT NOT NULL AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    u_id INT,
    streamingID NUMERIC(6),
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(auditNum)
);


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
(1, 'DIRECTV Stream', 79.99, 0, 0),
(2, 'Hulu', 7.99, 0, 0),
(3, 'NBA TV', 6.99, 0, 0),
(4, 'Sling TV', 61.00, 0, 0),
(5, 'YouTube TV', 82.99, 0, 0),
(6, 'ESPN+', 10.99, 0, 0),
(7, 'Fubo', 74.99, 0, 0),
(8, 'NBA League Pass', 14.99, 0, 0),
(9, 'Max', 16.99, 0, 0),
(10, 'Amazon Prime', 14.99, 0, 0);

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
(10, 10, 10, 7, 1, 'New York Knicks', 2, 8, 425);



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



-- -------------------------

-- PROCEDURES

--- SUPPORT FOR SEARCH BAR and PLAYER PAGE FROM MILESTONE 2
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetPlayerByName(IN player_name VARCHAR(100))
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.height, p.age, p.salary, t.Name as team_name
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID
  WHERE p.Name LIKE CONCAT('%', player_name, '%'); -- FUZZY SEARCH
END$$
DELIMITER ;

--- SUPPORT FOR GETTING PLAYERS
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetAllPlayers()
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.height, p.age, p.salary, t.name as team_name
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID;
END$$
DELIMITER ;

--- SUPPORT FOR SHOWING TEAMS IN A CONFERENCE
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetTeamsInConference(IN conference_name VARCHAR(100))
BEGIN
  SELECT 
    t.teamID, t.Name, t.Championships_Won, t.playoffs_won, t.earnings, 
    c.side AS ConferenceSide
  FROM Team t
  INNER JOIN Conference c ON t.conferenceID = c.conferenceID
  WHERE c.side LIKE CONCAT('%', conference_name, '%');
END$$
DELIMITER ;


--- SUPPORT FOR SHOWING A TEAM'S INFO
--- MIGHT BE MORE IN CASE IM FORGETTING SOME ATTRIBUTES
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetTeamInfo(IN team_name VARCHAR(100))
BEGIN
  SELECT
    t.TeamID, t.Name AS TeamName, t.Championships_Won, t.Playoffs_Won, t.Earnings,
    c.Name AS CoachName,
    s.Name AS StadiumName, s.Location AS StadiumLocation, s.Capacity AS StadiumCapacity,
    sp.Name AS SponsorName, sp.Money AS SponsorMoney,
    co.Side AS ConferenceSide
  FROM Team t
  INNER JOIN Coach c ON t.coachID = c.coachID
  INNER JOIN Stadium s ON t.stadiumID = s.stadiumID
  INNER JOIN Sponsor sp ON t.sponsorID = sp.sponsorID
  INNER JOIN Conference co ON t.conferenceID = co.conferenceID
  WHERE t.Name LIKE CONCAT('%', team_name, '%');
END$$
DELIMITER ;

--- SUPPORT FOR MATCHES INFORMATION, currently using date depending on what we want this may be adjusted later on
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetMatchInfoByDate(IN match_date DATE)
BEGIN
  SELECT 
    m.matchID, m.score, m.Ticket_Cost, m.Date, 
    t1.Name AS HomeTeamName, 
    t2.Name AS VisitingTeamName, 
    s.Name AS StadiumName, 
    r.Name AS RefereeName, 
    ss.Name AS StreamingService,
    m.BracketID
  FROM `match` m
  INNER JOIN Team t1 ON m.HomeTeamID = t1.teamID
  INNER JOIN Team t2 ON m.VisitingTeamID = t2.teamID
  INNER JOIN Stadium s ON m.stadiumID = s.stadiumID
  INNER JOIN Referee r ON m.refereeID = r.refereeID
  INNER JOIN Streaming_Service ss ON m.streamingID = ss.streamingID
  WHERE m.Date = match_date;
END$$
DELIMITER ;

-- FUNCTIONS
DELIMITER $$
CREATE FUNCTION CountPlayersByTeam(team_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total
  FROM Player p
  JOIN Team t ON p.teamID = t.teamID
  WHERE t.name LIKE team_name;
  RETURN total;
END$$
DELIMITER ;

-- TRIGGERS
DELIMITER @@
CREATE TRIGGER update_championships_won
AFTER INSERT ON Playoff
FOR EACH ROW
BEGIN
  UPDATE Team
  SET Championships_Won = Championships_Won + 1
  WHERE TeamID = NEW.ChampionID;
END@@
DELIMITER ;


DELIMITER @@
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
END@@
DELIMITER ;

DROP TRIGGER IF EXISTS ratingAdded; --For testing purposes
DELIMITER $$
CREATE TRIGGER ratingAdded
AFTER INSERT ON rating
FOR EACH ROW 
BEGIN
    INSERT INTO ratingAuditLog (Date, Time, u_id, streamingID) VALUES
    (CURRENT_DATE, CURRENT_TIMESTAMP, NEW.u_id, NEW.streamingID);

    UPDATE streaming_service 
    SET rating = (rating + NEW.score)/(numRatings + 1),
    numRatings = numRatings + 1
    WHERE streamingID = NEW.streamingID;
END$$
DELIMITER;

-- -------------------------

