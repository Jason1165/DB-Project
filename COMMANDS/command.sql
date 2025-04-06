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