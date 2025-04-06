CREATE TABLE team (
    teamID NUMERIC(6),
    coachID NUMERIC(6),
    stadiumID NUMERIC(6),
    sponsorID NUMERIC(6),
    conferenceID NUMERIC(6),
    name VARCHAR(100),
    championships_won INT,
    playoffs_won INT,
    earnings FLOAT,
    PRIMARY KEY(teamID),
    FOREIGN KEY(coachID) REFERENCES coach(coachID),
    FOREIGN KEY(stadiumID) REFERENCES stadium(stadiumID),
    FOREIGN KEY(sponsorID) REFERENCES sponsor(sponsorID),
    FOREIGN KEY(conferenceID) REFERENCES conference(conferenceID)
);
