class MgrsGridSerializer < ActiveModel::Serializer
  attributes :name, :utm_zone, :latitude_band, :grid_square, :latitude, :longitude, :epsg
end
