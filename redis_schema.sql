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
  Values ('Daisy dukes', 'dumb.com', 2);
insert into original (name, photo_url, user_id)
  Values ('Black Jeans', 'somesite.com', 2);
insert into original (name, photo_url, user_id)
  Values ('big cup', 'bingo.com', 1);
insert into original (name, photo_url, user_id)
  Values ('Blue Jeans', 'www.google.com', 1);


DROP FUNCTION IF EXISTS cache_items();
CREATE FUNCTION cache_items() RETURNS text AS $$
DECLARE
  citem RECORD;
BEGIN
  RAISE NOTICE 'Caching the next 10 items...';

  FOR citem in SELECT * FROM original LOOP
    -- Now citems has one record from original
  
    RAISE NOTICE 'Caching item %1... ', quote_ident(citem.name);
    -- insert redis_fdw here
    -- do i need to call the stringifying funciton from somewhere else into the loop?

    EXECUTE format('insert into cached_table values (''{"votes": 1, "photo_url": "www.google.com"}'')');
    /* PERFORM format('INSERT INTO cached_table VALUES(hello)'); */
  END LOOP;

  RAISE NOTICE 'Done caching items.';
  RETURN citem;
END;

$$ LANGUAGE plpgsql;

SELECT cache_items();

