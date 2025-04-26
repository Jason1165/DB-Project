-- Admin privileges
CREATE ROLE 'Sadmin';
GRANT ALL PRIVILEGES ON db4.* TO 'Sadmin';

-- User privileges
CREATE ROLE 'Suser';

GRANT SELECT ON db4.player TO 'Suser';
GRANT SELECT ON db4.team TO 'Suser';
GRANT SELECT ON db4.match TO 'Suser';
GRANT SELECT ON db4.streaming_service TO 'Suser';
GRANT SELECT ON db4.bracket TO 'Suser';
GRANT SELECT ON db4.conference TO 'Suser';
GRANT SELECT ON db4.rating TO 'Suser';

GRANT INSERT, UPDATE, DELETE ON db4.rating TO 'Suser';