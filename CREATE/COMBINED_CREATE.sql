CREATE TABLE coach (
    coachID INT AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    salary float,
    PRIMARY KEY(coachID)
);


CREATE TABLE stadium (
    stadiumID INT AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100),
    capacity INT,
    revenue INT,
    PRIMARY KEY(stadiumId)
);

CREATE TABLE sponsor (
    sponsorID INT AUTO_INCREMENT,
    name VARCHAR(100),
    money FLOAT,
    PRIMARY KEY(sponsorID)
);

CREATE TABLE conference (
    conferenceID INT AUTO_INCREMENT,
    side VARCHAR(100),
    PRIMARY KEY (conferenceID)
);


CREATE TABLE streaming_service (
    streamingID INT AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(5,2),
    rating FLOAT,
    numRatings INT,
    PRIMARY KEY (streamingID)
);

CREATE TABLE bracket (
    bracketID INT AUTO_INCREMENT,
    numTeams INT,
    season VARCHAR(100),
    PRIMARY KEY (bracketID)
);

CREATE TABLE team (
    teamID INT AUTO_INCREMENT,
    coachID INT,
    stadiumID INT,
    sponsorID INT,
    conferenceID INT,
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


CREATE TABLE player (
    playerID INT AUTO_INCREMENT,
    teamID INT,
    name VARCHAR(100),
    position VARCHAR(20),
    number INT,
    height int,
    age INT,
    salary float,
    PRIMARY KEY(playerID),
    FOREIGN KEY(teamID) REFERENCES team(teamID)
);


CREATE TABLE donation (
    donationID INT AUTO_INCREMENT,
    teamID INT NOT NULL,
    sponsorID INT NOT NULL,
    amount INT,
    PRIMARY KEY (donationID),
    FOREIGN KEY (teamID) REFERENCES team(teamID),
    FOREIGN KEY (sponsorID) REFERENCES sponsor(sponsorID)
);

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


-- "match" is a reserved keyword
CREATE TABLE `match` (
    matchID INT AUTO_INCREMENT,
    homeTeamID INT,
    visitingTeamID INT,
    stadiumID INT,
    streamingID INT,
    refereeID INT,
    bracketID INT,
    homeScore INT,
    visitingScore INT,
    ticket_cost FLOAT,
    date DATE,
    `round` INT DEFAULT NULL,
    PRIMARY KEY(matchID),
    FOREIGN KEY(homeTeamID) REFERENCES team(teamID),
    FOREIGN KEY(visitingTeamID) REFERENCES team(teamID),
    FOREIGN KEY(stadiumID) REFERENCES stadium(stadiumID),
    FOREIGN KEY(refereeID) REFERENCES referee(refereeID),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    FOREIGN KEY(bracketID) REFERENCES bracket(bracketID)
);


CREATE TABLE user (
    u_id INT AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE,
    password VARCHAR(255),
    PRIMARY KEY(u_id)
);


CREATE TABLE rating (
    score FLOAT,
    u_id INT,
    streamingID INT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(u_id, streamingID)
);

CREATE TABLE ratingAuditLog (
    auditNum INT NOT NULL AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    Type VARCHAR(10),
    u_id INT,
    streamingID INT,
    score FLOAT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(auditNum)
);

