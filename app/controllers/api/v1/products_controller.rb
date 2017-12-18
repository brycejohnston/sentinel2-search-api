class API::V1::ProductsController < API::APIController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

end
