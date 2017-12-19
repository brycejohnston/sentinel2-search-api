class API::V1::TilesController < API::APIController

  def index
    if params.has_key?(:mgrs)
      @tiles = Tile.where(mgrs_grid_name: params[:mgrs])
      if params.has_key?(:start_date)
        @tiles.where("date >= ?", params[:start_date])
      end
      if params.has_key?(:end_date)
        @tiles.where("date <= ?", params[:end_date])
      end
      @tiles.order(date: :asc)
    else
      @tiles = []
    end
    render json: @tiles
  end

end
