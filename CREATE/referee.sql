CREATE TABLE referee (
    refereeID NUMERIC(6),
    favoriteTeamID NUMERIC(6),
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY(refereeID),
    FOREIGN KEY(favoriteTeamID) REFERENCES team(teamID)
);
