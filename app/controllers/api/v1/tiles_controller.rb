class API::V1::TilesController < API::APIController

  def index
    if params.has_key?(:mgrs)
      @tiles = Tile.where(mgrs_grid_name: params[:mgrs]) if params[:mgrs].present?
      @tiles = @tiles.where("date >= ?", params[:start_date]) if params[:start_date].present?
      @tiles = @tiles.where("date <= ?", params[:end_date]) if params[:end_date].present?
      @tiles = @tiles.where("cloudy_pixel_percentage <= ?", params[:cloud_max]) if params[:cloud_max].present?
      @tiles = @tiles.where("data_coverage_percentage >= ?", params[:data_min]) if params[:data_min].present?
      @tiles = @tiles.order(date: :asc)
    else
      @tiles = []
    end
    render json: @tiles
  end

end
