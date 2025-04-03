CREATE TABLE streaming_service (
    streamingID NUMERIC(6),
    name VARCHAR(50),
    price DECIMAL(5,2),
    rating INT,
    PRIMARY KEY (streamingID)
);

INSERT INTO streaming_service VALUES
(1, 'DIRECTV Stream', 79.99, 4),
(2, 'Hulu', 7.99, 4),
(3, 'NBA TV', 6.99, 4),
(4, 'Sling TV', 61.00, 3),
(5, 'YouTube TV', 82.99, 4),
(6, 'ESPN+', 10.99, 4),
(7, 'Fubo', 74.99, 4),
(8, 'NBA League Pass', 14.99, 4),
(9, 'Max', 16.99, 4),
(10, 'Amazon Prime', 14.99, 4);
