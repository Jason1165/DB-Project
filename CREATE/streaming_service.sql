CREATE TABLE streaming_service (
    streamingID INT AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(5,2),
    rating FLOAT,
    numRatings INT,
    streamingLink VARCHAR(255),
    PRIMARY KEY (streamingID)
);