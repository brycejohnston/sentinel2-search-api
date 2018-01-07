class API::V1::MgrsGridsController < API::APIController
  before_action :set_mgrs_grid, only: [:show]

  def closest
    if params.has_key?(:latitude) && params.has_key?(:longitude)
      grids = MgrsGrid.closest_to(params[:latitude], params[:longitude])
      @grid = nil
      unless grids.nil?
        @grid = grids.first
      end
    else
      @grid = nil
    end
    render json: @grid
  end

  private

    #def set_mgrs_grid
    #  @mgrs_grid = MgrsGrid.find_by(params[:name])
    #end

end
