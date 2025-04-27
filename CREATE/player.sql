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
