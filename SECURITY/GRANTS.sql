-- User privileges
DROP ROLE 'Suser';
CREATE ROLE 'Suser';

-- Views for public
CREATE OR REPLACE VIEW playerPublic AS 
SELECT name, position, number, height, age, salary
FROM db4.player;

CREATE OR REPLACE VIEW teamPublic AS
SELECT name, championships_won, playoffs_won, earnings
FROM db4.team;

CREATE OR REPLACE VIEW ratingPublic AS
SELECT score
FROM db4.rating;
-- Granting said views
GRANT SELECT ON db4.playerPublic TO 'Suser';
GRANT SELECT ON db4.teamPublic TO 'Suser';
GRANT SELECT ON db4.ratingPublic TO 'Suser';
-- I don't believe we need these as of now because these aren't really searchable
-- uncomment if it breaks things in accessing said info, then comment the views out 
-- GRANT SELECT ON db4.match TO 'Suser';
-- GRANT SELECT ON db4.streaming_service TO 'Suser';
-- GRANT SELECT ON db4.bracket TO 'Suser';
-- GRANT SELECT ON db4.conference TO 'Suser';
-- GRANT SELECT ON db4.rating TO 'Suser';

GRANT INSERT, UPDATE, DELETE ON db4.rating TO 'Suser';