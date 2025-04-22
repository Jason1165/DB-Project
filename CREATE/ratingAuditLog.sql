CREATE TABLE ratingAuditLog (
    auditNum INT NOT NULL AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    Type VARCHAR(10),
    u_id INT,
    streamingID NUMERIC(6),
    score FLOAT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(auditNum)
);