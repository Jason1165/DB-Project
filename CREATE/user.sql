CREATE TABLE user (
    u_id INT AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE,
    password VARCHAR(255),
    PRIMARY KEY(u_id)
);
