CREATE TABLE ratingAuditLog (
    auditNum INT NOT NULL AUTO_INCREMENT,
    Date DATE,
    Time TIME,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(s_id),
    PRIMARY KEY(auditNum)
);