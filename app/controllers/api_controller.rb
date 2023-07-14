class ApiController < ActionController::API
  include JsonWebToken

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  # before_action :student_authenticate_request

  private

  # protected

  def authenticate_request
    begin
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)

      @current_user = User.find(decoded[:user_id])
    rescue
      render json: { message: "Please Provide Right token" }, status: 400
    end
  end
end
