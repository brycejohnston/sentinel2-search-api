class MgrsGrid < ApplicationRecord
  has_many :tiles, primary_key: 'name', foreign_key: 'mgrs_grid_name'

  validates_uniqueness_of :name

  scope :closest_to, -> (lat, lng, distance_in_meters = 100000) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || mgrs_grids.longitude || ' ' || mgrs_grids.latitude || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [lng, lat, distance_in_meters])
    .order(%{
      ST_Distance(
        ST_Geomfromtext(
          'POINT(' || mgrs_grids.longitude || ' ' || mgrs_grids.latitude || ')'
        ),
        ST_Geomfromtext('POINT(%f %f)')
      )
    } % [lng, lat])
  }
end
