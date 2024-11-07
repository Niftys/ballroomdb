CREATE USER 'readonly'@'%' IDENTIFIED BY 'password';
GRANT SELECT ON ballroomdb.* TO 'readonly'@'%';
FLUSH PRIVILEGES;