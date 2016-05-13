DROP FUNCTION IF EXISTS cache_items();
CREATE FUNCTION cache_items() RETURNS text AS $$
DECLARE
  citem RECORD;
BEGIN
  RAISE NOTICE 'Caching the next 10 items...';

  FOR citem in SELECT * FROM original LOOP
    RAISE NOTICE 'Caching item %1... ', quote_ident(citem.name);

    EXECUTE format('INSERT INTO rft_set ( key, member, expiry ) values ($1, $2, $3)')
    USING citem.id, to_json(citem), 100000;
  END LOOP;

  RAISE NOTICE 'Done caching items.';
  RETURN citem;
END;

$$ LANGUAGE plpgsql;

SELECT cache_items();

