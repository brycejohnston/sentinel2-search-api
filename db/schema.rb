# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171218230701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "mgrs_grids", force: :cascade do |t|
    t.string "name"
    t.integer "utm_zone"
    t.string "latitude_band"
    t.string "grid_square"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "uuid"
    t.string "path"
    t.datetime "timestamp"
    t.string "datatake_identifier"
    t.datetime "scihub_ingestion"
    t.datetime "s3_ingestion"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiles", force: :cascade do |t|
    t.string "mgrs_grid_name"
    t.integer "utm_zone"
    t.string "latitude_band"
    t.string "grid_square"
    t.string "path"
    t.date "date"
    t.datetime "timestamp"
    t.string "epsg"
    t.string "product_name"
    t.string "product_path"
    t.decimal "data_coverage_percentage"
    t.decimal "cloudy_pixel_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
