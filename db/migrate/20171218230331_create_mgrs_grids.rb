class CreateMgrsGrids < ActiveRecord::Migration[5.1]
  def change
    create_table :mgrs_grids do |t|
      t.string :name
      t.integer :utm_zone
      t.string :latitude_band
      t.string :grid_square
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
