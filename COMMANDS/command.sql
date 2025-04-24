-- PROCEDURES

--- SUPPORT FOR SEARCH BAR and PLAYER PAGE FROM MILESTONE 2
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetPlayerByName(IN player_name VARCHAR(100))
BEGIN
  SELECT p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID
  WHERE p.Name LIKE CONCAT('%', player_name, '%'); -- FUZZY SEARCH
END$$
DELIMITER ;

--- 
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetPlayerByTeam(IN team_name VARCHAR(100))
BEGIN
  SELECT p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID
  WHERE t.Name LIKE CONCAT('%', team_name, '%'); -- FUZZY SEARCH
END$$
DELIMITER ;

---
DELIMITER $$
CREATE OR REPLACE PROCEDURE GetPlayerByPosition(IN position_name VARCHAR(100))
BEGIN
  SELECT p.Name, p.Position, p.Number, p.Height, p.Age, p.Salary, t.Name as TeamName
  FROM Player p
  INNER JOIN Team t on p.teamID = t.teamID
  WHERE p.Position LIKE CONCAT('%', position_name, '%'); -- FUZZY SEARCH
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
DROP TRIGGER IF EXISTS update_championships_won;
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


DROP TRIGGER IF EXISTS new_donation;
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

DROP TRIGGER IF EXISTS ratingAdded; 
DELIMITER $$
CREATE TRIGGER ratingAdded
AFTER INSERT ON rating
FOR EACH ROW 
BEGIN
    INSERT INTO ratingAuditLog (Date, Time, Type, score, u_id, streamingID) VALUES
    (CURRENT_DATE, CURRENT_TIMESTAMP, "INSERT", NEW.score, NEW.u_id, NEW.streamingID);

    UPDATE streaming_service 
    SET rating = (rating + NEW.score)/(numRatings + 1),
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