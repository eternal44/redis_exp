DROP TABLE IF EXISTS original CASCADE;
CREATE TABLE original (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  photo_url VARCHAR(50),
  user_id integer
);

DROP FOREIGN TABLE IF EXISTS rft_set CASCADE;
CREATE FOREIGN TABLE rft_set(
  key    TEXT,
  member TEXT,
  expiry INT
) SERVER redis_server
OPTIONS (tabletype 'set');

/* MOCK DATA */
insert into original (name, photo_url, user_id)
  Values ('Blue Anchor', 'ba.com', 2);
insert into original (name, photo_url, user_id)
  Values ('Black Jeans', 'somesite.com', 2);
insert into original (name, photo_url, user_id)
  Values ('big cup', 'bingo.com', 1);
insert into original (name, photo_url, user_id)
  Values ('Blue Jeans', 'www.google.com', 1);


