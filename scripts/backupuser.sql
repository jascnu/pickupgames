create user backup_user with password 'notourpassword';
GRANT CONNECT ON DATABASE pickupgames TO backup_user;
--Grant read to all tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO backup_user;
--Automatically grant read access to new tables
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO backup_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO backup_user;

--Make read only
alter user backup_user set default_transaction_read_only = on;