# Sentinel-2 MGRS Tile Search API

Simple API to query Sentinel-2 data by MGRS on AWS. Data imported with the
[sentinel2_aws gem](https://github.com/beaorn/sentinel2_aws).

Live version is deployed at https://sentinel2.cropquest.net

## Setup

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

## Running Project

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

### Import product and tile data by date range
```ruby
(Date.new(2017, 12, 01)..Date.new(2017, 12, 31)).each do |date|
  date_str = date.strftime("%Y-%m-%d")
  SentinelWorker.perform_async(date_str)
end
```
