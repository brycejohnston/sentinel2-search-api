# Sentinel-2 Search API

Simple API to query Sentinel-2 data on AWS

### Setup

Clone project, copy database and secrets example configs and set them up.
```bash
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
```

Install gems, setup database, run migrations, and seed database
```bash
bundle install
createdb sentinel2-search-api_development
psql sentinel2-search-api_development
```

```sql
CREATE SCHEMA postgis;
CREATE EXTENSION postgis WITH SCHEMA postgis;
\q
```

```bash
rails db:migrate
rails import_mgrs_grids
```

### Running Project

Start server
```bash
bundle exec rails server
```

Start sidekiq (requires redis server to be running)
```bash
bundle exec sidekiq
```

### Import product and tile data by date
```ruby
SentinelWorker.perform_async("2017-12-14")
```
