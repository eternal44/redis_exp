CREATE EXTENSION redis_fdw;

CREATE SERVER redis_server 
FOREIGN DATA WRAPPER redis_fdw 
OPTIONS (host '127.0.0.1', port '6379');

CREATE USER MAPPING FOR PUBLIC
SERVER redis_server
OPTIONS (password 'secret');
