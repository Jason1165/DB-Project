CREATE TABLE rating (
    rid INT AUTO_INCREMENT,
    score FLOAT,
    u_id INT,
    streamingID NUMERIC(6),
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(rid)
);