class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  # attr_reader :current_user
  # helper_method :current_user

  private

  #
  # def authenticate_request
  #   @current_user = AuthorizeApiRequest.call(request.headers).result
  #
  #   render json: Error.unauthorized, status: 401 unless @current_user
  # end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.token_from_headers(token)
    end
  end
end
