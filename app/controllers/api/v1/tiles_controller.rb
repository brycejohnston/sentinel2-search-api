class API::V1::TilesController < API::APIController
  before_action :set_tile, only: [:show]

  def index
    @tiles = Tile.all
    render json: @tiles
  end

  def show
    render json: @tile
  end

  private

    def set_tile
      @tile = Tile.find(params[:id])
    end

end
