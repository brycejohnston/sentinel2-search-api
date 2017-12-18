class CreateTiles < ActiveRecord::Migration[5.1]
  def change
    create_table :tiles do |t|
      t.string :mgrs_grid_name
      t.integer :utm_zone
      t.string :latitude_band
      t.string :grid_square
      t.string :path
      t.date :date
      t.datetime :timestamp
      t.string :epsg
      t.string :product_name
      t.string :product_path
      t.decimal :data_coverage_percentage
      t.decimal :cloudy_pixel_percentage

      t.timestamps
    end
  end
end
