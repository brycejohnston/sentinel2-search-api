class API::APIController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    respond_with '{"error": "not_found"}', status: :not_found
  end

end
