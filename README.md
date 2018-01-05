# Sentinel-2 MGRS Tile Search API

Simple Ruby on Rails based API to query Sentinel-2 data by MGRS on AWS. Data imported daily from AWS with
the [sentinel2_aws gem](https://github.com/satgateway/sentinel2_aws).

Live version is deployed at https://sentinel2.satgateway.com

Tile Preview Viewer implementing this API: [sentinel2-search-viewer](https://github.com/satgateway/sentinel2-search-viewer)

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
(Date.new(2017, 12, 1)..Date.new(2017, 12, 31)).each do |date|
  date_str = date.strftime("%Y-%m-%d")
  SentinelWorker.perform_async(date_str)
end
```

### Scheduled Daily Imports
Add scheduled calls to SentinelWorker in `config/schedule.rb`.

## API Examples

- mgrs parameter format is utm_zone + latitude_band + grid_square
- start_date and end_date parameter formats are YYYY-MM-DD

### Get all tiles for 14SQJ
http://localhost:3000/api/v1/tiles?mgrs=14SQJ

### Get all tiles for 14SQJ with date >= 2017-01-01
http://localhost:3000/api/v1/tiles?mgrs=14SQJ&start_date=2017-01-01

### Get all tiles for 14SQJ with date <= 2017-10-15
http://localhost:3000/api/v1/tiles?mgrs=14SQJ&end_date=2017-10-15

### Get all tiles for 14SQJ between 2017-01-01 and 2017-10-15
http://localhost:3000/api/v1/tiles?mgrs=14SQJ&start_date=2017-01-01&end_date=2017-10-15

### Get all tiles for 14SQJ with <= 50% cloud coverage
http://localhost:3000/api/v1/tiles?mgrs=14SQJ&cloud_max=50

### Get all tiles for 14SQJ with >= 10% data coverage
http://localhost:3000/api/v1/tiles?mgrs=14SQJ&data_min=10

### API Response Format
```json
[
  {
    "mgrs_grid_name": "14SQJ",
    "utm_zone": 14,
    "latitude_band": "S",
    "grid_square": "QJ",
    "path": "tiles/14/S/QJ/2017/11/16/0",
    "date": "2017-11-16",
    "timestamp": "2017-11-16T17:16:01.462Z",
    "epsg": "32614",
    "product_name": "S2A_MSIL1C_20171116T171601_N0206_R112_T14SQJ_20171116T191006",
    "product_path": "products/2017/11/16/S2A_MSIL1C_20171116T171601_N0206_R112_T14SQJ_20171116T191006",
    "data_coverage_percentage": "100.0",
    "cloudy_pixel_percentage": "55.69",
    "thumbnail": "https://sentinel-s2-l1c.s3.amazonaws.com/tiles/14/S/QJ/2017/11/16/0/preview.jpg"
  },
]
```
