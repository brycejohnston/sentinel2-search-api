class AddEpsgToMgrsGrids < ActiveRecord::Migration[5.1]
  def change
    add_column :mgrs_grids, :epsg, :string
    change_column :mgrs_grids, :utm_zone, :string
  end
end
