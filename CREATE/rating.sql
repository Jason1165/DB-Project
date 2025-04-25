CREATE TABLE rating (
    score INT,
    u_id INT,
    streamingID INT,
    FOREIGN KEY(u_id) REFERENCES user(u_id),
    FOREIGN KEY(streamingID) REFERENCES streaming_service(streamingID),
    PRIMARY KEY(u_id, streamingID)
);