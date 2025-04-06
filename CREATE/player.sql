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
