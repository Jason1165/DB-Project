-- FUNCTION
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



-- TRIGGER
CREATE TRIGGER update_championships_won
AFTER INSERT ON Playoffs
FOR EACH ROW
BEGIN
  UPDATE Team
  SET Championships_Won = Championships_Won + 1
  WHERE TeamID = NEW.ChampionID;
END;

