DROP TABLE IF EXISTS original CASCADE;
CREATE TABLE original (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  photo_url VARCHAR(50),
  user_id integer
);

DROP TABLE IF EXISTS cached_table CASCADE;
CREATE TABLE cached_table (
  item JSON
);

insert into original (name, photo_url, user_id)
  Values ('Black Jeans', 'somesite.com', 2);
insert into original (name, photo_url, user_id)
  Values ('big cup', 'bingo.com', 1);
insert into original (name, photo_url, user_id)
  Values ('Blue Jeans', 'www.google.com', 1);


CREATE FUNCTION cache_items() RETURNS integer AS $$
DECLARE
  citems RECORD;
BEGIN
  RAISE NOTICE 'Caching the next 10 items...';

  FOR citems in SELECT * FROM original LOOP
    -- Now citems has one record from original
  
    RAISE NOTICE 'Caching item... ';
    -- insert redis_fdw here
  END LOOP;

  RAISE NOTICE 'Done caching items.';
  RETURN 1;
END;

$$ LANGUAGE plpgsql;

