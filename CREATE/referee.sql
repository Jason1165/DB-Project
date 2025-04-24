CREATE TABLE referee (
    refereeID INT AUTO_INCREMENT,
    favoriteTeamID INT,
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    PRIMARY KEY(refereeID),
    FOREIGN KEY(favoriteTeamID) REFERENCES team(teamID)
);
