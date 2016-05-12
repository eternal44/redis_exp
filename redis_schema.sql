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


DROP FUNCTION IF EXISTS cache_items();
CREATE FUNCTION cache_items() RETURNS integer AS $$
DECLARE
  citem RECORD;
BEGIN
  RAISE NOTICE 'Caching the next 10 items...';

  FOR citem in SELECT * FROM original LOOP
    -- Now citems has one record from original
  
    RAISE NOTICE 'Caching item %s... ', quote_ident(citem.name);
    -- insert redis_fdw here
    /* insert into unvoted values (1, '{"votes": 1, "photo_url": "www.google.com"}'); */
    EXECUTE format ('INSERT INTO cached_table VALUES %I %p %u', citem.name, citem.photo_url, citem.user_id);
  END LOOP;

  RAISE NOTICE 'Done caching items.';
  RETURN 1;
END;

$$ LANGUAGE plpgsql;

