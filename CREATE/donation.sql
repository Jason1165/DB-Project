CREATE TABLE donation (
    donationID INT AUTO_INCREMENT,
    teamID INT NOT NULL,
    sponsorID INT NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);