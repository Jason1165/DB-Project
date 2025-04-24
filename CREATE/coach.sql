CREATE TABLE coach (
    coachID INT AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    start_date DATE,
    end_date DATE NULL,
    salary float,
    PRIMARY KEY(coachID)
);
