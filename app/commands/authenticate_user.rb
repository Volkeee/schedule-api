# app/commands/authenticate_user.rb

class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, token)
    @email = email
    @token = token
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :token

  def user
    user = User.find_by_email(email)
    return user if user && user.check_token(token)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
