class API::V1::MgrsGridsController < API::APIController
  before_action :set_mgrs_grid, only: [:show]

  def index
    @mgrs_grids = MgrsGrid.all
    render json: @mgrs_grids
  end

  def show
    render json: @mgrs_grid
  end

  private

    def set_mgrs_grid
      @mgrs_grid = MgrsGrid.find(params[:id])
    end

end
