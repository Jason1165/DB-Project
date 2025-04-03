CREATE TABLE bracket (
    bracketID NUMERIC(6),
    numTeams INT,
    season VARCHAR(50),
    PRIMARY KEY (bracketID)
);

-- year changed to season cause keyword
-- season can also be VARCHAR depending on design choice