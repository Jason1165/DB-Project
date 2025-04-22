--Admin privileges
CREATE ROLE Sadmin;
GRANT ALL PRIVILEGES ON *.* TO 'Sadmin';

--User privileges
CREATE ROLE Suser;

GRANT SELECT ON *.player TO Suser;
GRANT SELECT ON *.team TO Suser;
GRANT SELECT ON *.match TO Suser;
GRANT SELECT ON *.streaming_service TO Suser;
GRANT SELECT ON *.bracket TO Suser;
GRANT SELECT ON *.conference TO Suser;
GRANT SELECT ON *.rating TO Suser;

GRANT INSERT, UPDATE, DELETE ON *.rating TO Suser;