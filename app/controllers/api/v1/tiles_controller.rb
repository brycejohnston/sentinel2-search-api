class API::V1::TilesController < API::APIController

  def index
    if params.has_key?(:mgrs)
      @tiles = Tile.where(mgrs_grid_name: params[:mgrs])
      @tiles.where("date >= ?", params[:start_date]) if params.has_key?(:start_date)
      @tiles.where("date <= ?", params[:end_date]) if params.has_key?(:end_date)
    else
      @tiles = []
    end
    render json: @tiles
  end

end
