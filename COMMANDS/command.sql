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
DELIMITER;

--- SUPPORT FOR GETTING PLAYERS
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetAllPlayers()
BEGIN
  SELECT p.playerID, p.Name, p.Position, p.height, p.age, p.salary, t.name as team_name
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID;
END$$
DELIMITER;

--- SUPPORT FOR SHOWING TEAMS IN A CONFERENCE
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetTeamsInConference(IN conference_name VARCHAR(100))
BEGIN
  SELECT t.teamID, t.Name, t.Championships_Won, t.playoffs_won, t.earnings, t.side as ConferenceSide
  FROM Team t
  INNER JOIN Conference c ON t.conferenceID = c.conferenceID
  WHERE c.side LIKE conference_name;
END$$
DELIMITER;

--- SUPPORT FOR SHOWING A TEAM'S INFO
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetTeamInfo(IN team_name VARCHAR(100))
BEGIN
  SELECT --- MIGHT BE MORE IN CASE IM FORGETTING SOME ATTRIBUTES
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
  WHERE t.Name LIKE team_name;
END$$
DELIMITER;

--- SUPPORT FOR MATCHES INFORMATION, currently using date depending on what we want this may be adjusted later on
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetMatchInfoByDate(IN match_date DATE)
BEGIN
  SELECT 
    m.m.matchID, m.score, m.Ticket_Cost, m.Date, 
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
DELIMITER;

-- FUNCTIONS
DELIMITER $$
CREATE FUNCTION CountPlayersByTeam(team_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total
  FROM Player p
  JOIN Team t ON p.teamID = t.teamID
  WHERE t.name LIKE team_name;
  RETURN total;
END $$
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
DELIMITER;


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