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
