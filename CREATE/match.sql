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
