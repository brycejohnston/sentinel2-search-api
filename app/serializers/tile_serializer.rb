class TileSerializer < ActiveModel::Serializer
  attributes :mgrs_grid_name, :utm_zone, :latitude_band, :grid_square, :path,
  :date, :timestamp, :epsg, :product_name, :product_path,
  :data_coverage_percentage, :cloudy_pixel_percentage, :thumbnail
end
