# An exploration into redis_fdw

### Installation
Run scripts with the following terminal commands:
```bash
  createdb test
  psql test < redis/config.sql
  psql test < schema.sql
```

### Start Redis server
Open up a new terminal and do the following:
```bash
  redis-server
```

### Run redis_fdw
Run the following to run the FDW:
```bash
  psql test
``` 

Once the Postgres console opens up run this query:
```sql
  SELECT * FROM rft_set WHERE key = '1';
```

Run that query again and you'll see the column for 'expiry' count down as well.

