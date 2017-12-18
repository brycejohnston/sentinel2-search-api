class SentinelWorker
  include Sidekiq::Worker

  def perform(date)
    @client = SentinelS3::Client.new(
      Rails.application.secrets.aws_access_key_id,
      Rails.application.secrets.aws_secret_access_key
    )
    @date = date
    process_products
  end

  def process_products
    product_objects = @client.get_products(@date)
    product_objects.each do |product_obj|
      product_str = product_obj.split('/')
      existing_product = Product.find_by(name: product_str[4])
      if existing_product.nil?
        metadata = @client.get_product_info(product_obj)
        product = Product.create(
          name: metadata[:name],
          uuid: metadata[:id],
          path: metadata[:path],
          timestamp: metadata[:timestamp],
          datatake_identifier: metadata[:datatake_identifier],
          scihub_ingestion: metadata[:scihub_ingestion],
          s3_ingestion: metadata[:s3_ingestion],
          date: @date,
        )
        metadata[:tiles].each do |tile_obj|
          mgrs_grid_name = "#{tile_obj[:utm_zone]}#{tile_obj[:latitude_band]}#{tile_obj[:grid_square]}"
          tile = Tile.create(
            mgrs_grid_name: mgrs_grid_name,
            path: tile_obj[:path],
            timestamp: tile_obj[:timestamp],
            utm_zone: tile_obj[:utm_zone],
            latitude_band: tile_obj[:latitude_band],
            grid_square: tile_obj[:grid_square],
            epsg: tile_obj[:epsg],
            data_coverage_percentage: tile_obj[:data_coverage_percentage],
            cloudy_pixel_percentage: tile_obj[:cloudy_pixel_percentage],
            date: @date,
            product_name: product.name,
            product_path: product.path
          )
        end
      end
    end
  end

end
