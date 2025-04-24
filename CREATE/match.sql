-- "match" is a reserved keyword
CREATE TABLE `match` (
    matchID INT AUTO_INCREMENT,
    homeTeamID INT,
    visitingTeamID INT,
    stadiumID INT,
    streamingID INT,
    refereeID INT,
    bracketID INT,
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
