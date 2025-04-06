CREATE TABLE donation (
    donationID NUMERIC(6),
    teamID NUMERIC(6) NOT NULL,
    sponsorID NUMERIC(6) NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);