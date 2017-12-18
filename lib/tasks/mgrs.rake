require 'csv'

task :import_mgrs_grids => :environment do
  CSV.foreach(Rails.root.join('vendor/mgrs_region.csv')).each do |row|
    utmlat = row[0]
    utm_zone = utmlat[0..1]
    latitude_band = utmlat[2..-1]
    grid_square = row[1]
    name = "#{utm_zone}#{latitude_band}#{grid_square}"
    MgrsGrid.create(
      name: name,
      utm_zone: utm_zone,
      latitude_band: latitude_band,
      grid_square: grid_square,
      longitude: row[2],
      latitude: row[3]
    )
  end
end
