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
