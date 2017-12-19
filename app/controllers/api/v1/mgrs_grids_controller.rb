class API::V1::MgrsGridsController < API::APIController
  before_action :set_mgrs_grid, only: [:show]

  #def show
  #  render json: @mgrs_grid
  #end

  private

    #def set_mgrs_grid
    #  @mgrs_grid = MgrsGrid.find_by(params[:name])
    #end

end
