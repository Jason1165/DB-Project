-- Create admin role
CREATE ROLE 'Sadmin';
GRANT ALL PRIVILEGES ON *.* TO 'Sadmin';

-- Create user role
CREATE ROLE 'Suser';

-- Replace 'your_database' with your actual database name
GRANT SELECT ON db4.player TO 'Suser';
GRANT SELECT ON db4.team TO 'Suser';
GRANT SELECT ON db4.match TO 'Suser';
GRANT SELECT ON db4.streaming_service TO 'Suser';
GRANT SELECT ON db4.bracket TO 'Suser';
GRANT SELECT ON db4.conference TO 'Suser';
GRANT SELECT ON db4.rating TO 'Suser';
GRANT INSERT, UPDATE, DELETE ON db4.rating TO 'Suser';

-- Make sure to flush privileges
FLUSH PRIVILEGES;
