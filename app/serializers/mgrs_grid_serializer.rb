class MgrsGridSerializer < ActiveModel::Serializer
  attributes :id, :name, :utm_zone, :latitude_band, :grid_square, :latitude, :longitude
end
