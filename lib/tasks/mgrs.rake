task :import_mgrs => :environment do
  MgrsGrid.destroy_all
  file = File.open(Rails.root.join('vendor/s2.geojson'))
  data = Oj.load(file)
  data["features"].each do |feature|
    name = feature["properties"]["name"]
    mgrs_grid = MgrsGrid.find_by(name: name)
    if mgrs_grid.nil?
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

      MgrsGrid.create(
        name: name,
        utm_zone: name[0..1],
        latitude_band: name[2],
        grid_square: name[3..4],
        longitude: longitude,
        latitude: latitude,
        epsg: epsg
      )
      puts "Created #{name} - #{latitude}, #{longitude}"
    end
  end
end
