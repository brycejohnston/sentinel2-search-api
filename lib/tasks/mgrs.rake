require 'csv'

task :mgrs_geojson_to_csv => :environment do
  MgrsGrid.destroy_all
  file = File.open(Rails.root.join('vendor/s2.geojson')) # converted sentinel 2 mgrs kml to geojson
  data = Oj.load(file)
  CSV.open(Rails.root.join('vendor/s2_mgrs.csv'), "wb") do |csv|
    data["features"].each do |feature|
      name = feature["properties"]["name"]
      latitude = 0
      longitude = 0
      feature["geometry"]["geometries"].each do |geom|
        if geom["type"] == "Point"
          latitude = geom["coordinates"][1]
          longitude = geom["coordinates"][0]
        end
      end

      desc = feature["properties"]["description"].split('<b>EPSG</b></font></td><td bgcolor="#E4E6CA"> <font COLOR="#008000">')
      epsg = desc[1].split("</font>").first
      csv << [
        name,
        name[0..1],
        name[2],
        name[3..4],
        longitude,
        latitude,
        epsg
      ]
    end
  end
end

task :import_mgrs_grids => :environment do
  MgrsGrid.destroy_all
  CSV.foreach(Rails.root.join('vendor/s2_mgrs.csv')).each do |row|
    MgrsGrid.create(
      name: row[0],
      utm_zone: row[1],
      latitude_band: row[2],
      grid_square: row[3],
      latitude: row[5],
      longitude: row[4],
      epsg: row[6]
    )
  end
end
