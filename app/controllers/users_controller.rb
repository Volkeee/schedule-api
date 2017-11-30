class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def new
    @user = User.new(user_params)
  end

  def create
    @group_params = group_params
    @group = Group.find(@group_params[:id])

    if User.exists?(name: user_params['name'], email: user_params['email'], origin: user_params['origin'])
      @user = User.find_by(name: user_params['name'], email: user_params['email'], origin: user_params['origin'])
      @user.tokens.find_by(device_params).nil? ? @token = @user.tokens.new(device_params) : @token = @user.tokens.find_by(device_params)
      unless @token.validity
        @token.validity = true
      end

    else
      @user = @group.users.new(user_params)
      @token = @user.tokens.new(device_params)

    end
    @token.save
    @user.save
    render json: {user: @user, token: @token}
  end

  def update
    @current_user.update(user_params)
  end

  def destroy
    @current_user.tokens.destroy_all
    @current_user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :origin)
  end

  def group_params
    params.require(:group).permit(:id)
  end

  def device_params
    params.require(:device).permit(:device_manufacturer, :device_model, :os_version)
  end
end
