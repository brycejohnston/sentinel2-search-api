class API::V1::TilesController < API::APIController

  def index
    if params.has_key?(:mgrs)
      @tiles = Tile.where(mgrs_grid_name: params[:mgrs]) if params[:mgrs].present?
      if params[:start_date].present?
        @tiles = @tiles.where("date >= ?", params[:start_date])
      end
      if params[:end_date].present?
        @tiles = @tiles.where("date <= ?", params[:end_date]) if params[:end_date].present?
      end
      @tiles = @tiles.order(date: :asc)
    else
      @tiles = []
    end
    render json: @tiles
  end

end
