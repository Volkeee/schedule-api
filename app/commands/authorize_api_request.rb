# app/commands/authorize_api_request.rb

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    @token = @headers['Authorization']
    @token = Token.find_by(token: @token)
    unless @headers['Authorization'].nil?
      if @token.validity
        @user = User.find(@token.user_id)
        @user.current_token = @token
        @user
      else
        false
      end
    end
  end
end
