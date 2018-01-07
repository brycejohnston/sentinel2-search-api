# Sentinel-2 MGRS Tile Search API

Simple Ruby on Rails based API to query Sentinel-2 data by MGRS on AWS. Data imported daily from AWS with
the [sentinel2_aws gem](https://github.com/satgateway/sentinel2_aws).

Live version is deployed at https://sentinel2.satgateway.com

Tile Preview Viewer implementing this API: [sentinel2-search-viewer](https://github.com/satgateway/sentinel2-search-viewer)

## Setup

Prerequisites: Ruby, Bundler, Ruby on Rails, PostgreSQL, PostGIS, and Redis

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

## Tile API Examples

- mgrs parameter format is utm_zone + latitude_band + grid_square
- start_date and end_date parameter formats are YYYY-MM-DD

### Get all tiles for 36RUU
http://localhost:3000/api/v1/tiles?mgrs=36RUU

### Get all tiles for 36RUU with date >= 2017-01-01
http://localhost:3000/api/v1/tiles?mgrs=36RUU&start_date=2017-01-01

### Get all tiles for 36RUU with date <= 2017-10-15
http://localhost:3000/api/v1/tiles?mgrs=36RUU&end_date=2017-10-15

### Get all tiles for 36RUU between 2017-01-01 and 2017-10-15
http://localhost:3000/api/v1/tiles?mgrs=36RUU&start_date=2017-01-01&end_date=2017-10-15

### Get all tiles for 36RUU with <= 50% cloud coverage
http://localhost:3000/api/v1/tiles?mgrs=36RUU&cloud_max=50

### Get all tiles for 36RUU with >= 10% data coverage
http://localhost:3000/api/v1/tiles?mgrs=36RUU&data_min=10

### Tile API Response Format
```json
[
  {
    "mgrs_grid_name": "36RUU",
    "utm_zone": 36,
    "latitude_band": "R",
    "grid_square": "UU",
    "path": "tiles/36/R/UU/2018/1/7/0",
    "date": "2018-01-07",
    "timestamp": "2018-01-07T08:49:36.450Z",
    "epsg": "32636",
    "product_name": "S2B_MSIL1C_20180107T084329_N0206_R064_T36RUU_20180107T110727",
    "product_path": "products/2018/1/7/S2B_MSIL1C_20180107T084329_N0206_R064_T36RUU_20180107T110727",
    "data_coverage_percentage": "17.6",
    "cloudy_pixel_percentage": "0.0",
    "thumbnail": "https://sentinel-s2-l1c.s3.amazonaws.com/tiles/36/R/UU/2018/1/7/0/preview.jpg"
  },
]
```

## MGRS API Example

### Find MGRS tile identifier for a given latitude and longitude
http://localhost:3000/api/v1/mgrs_grids/closest?latitude=29.979235&longitude=31.134202

### MGRS API Response Format
```json
{
  "name": "36RUU",
  "utm_zone": "36",
  "latitude_band": "R",
  "grid_square": "UU",
  "latitude": 31.4893138415,
  "longitude": 30.2278496385,
  "epsg": "32636"
}
```
