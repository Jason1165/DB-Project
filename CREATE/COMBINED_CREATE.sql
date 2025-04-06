CREATE TABLE coach (
    coachID NUMERIC(6),
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    salary float,
    PRIMARY KEY(coachID)
);


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


CREATE TABLE player (
    playerID NUMERIC(6),
    teamID NUMERIC(6),
    name VARCHAR(100),
    position VARCHAR(20),
    number INT,
    height int,
    age INT,
    salary float,
    PRIMARY KEY(playerID),
    FOREIGN KEY(teamID) REFERENCES team(teamID)
);


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


CREATE TABLE referee (
    refereeID NUMERIC(6),
    favoriteTeamID NUMERIC(6),
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    PRIMARY KEY(refereeID),
    FOREIGN KEY(favoriteTeamID) REFERENCES team(teamID)
);


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


CREATE TABLE bracket (
    bracketID NUMERIC(6),
    numTeams INT,
    season VARCHAR(50),
    PRIMARY KEY (bracketID)
);

CREATE TABLE conference (
    conferenceID NUMERIC(6),
    side VARCHAR(50),
    PRIMARY KEY (conferenceID)
);


CREATE TABLE donation (
    donationID NUMERIC(6),
    teamID NUMERIC(6) NOT NULL,
    sponsorID NUMERIC(6) NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);

CREATE TABLE sponsor (
    sponsorID NUMERIC(6),
    name VARCHAR(50),
    money FLOAT,
    PRIMARY KEY(sponsorID)
);

CREATE TABLE stadium (
    stadiumID NUMERIC(6),
    name CHAR(50),
    location CHAR(50),
    capacity INT,
    revenue INT,
    PRIMARY KEY(stadiumId)
);

CREATE TABLE streaming_service (
    streamingID NUMERIC(6),
    name VARCHAR(50),
    price DECIMAL(5,2),
    rating INT,
    PRIMARY KEY (streamingID)
);

