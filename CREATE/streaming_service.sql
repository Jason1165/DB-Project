CREATE TABLE streaming_service (
    streamingID NUMERIC(6),
    name VARCHAR(100),
    price DECIMAL(5,2),
    rating FLOAT,
    numRatings INT,
    PRIMARY KEY (streamingID)
);