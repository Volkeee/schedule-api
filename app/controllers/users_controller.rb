class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def new
    @user = User.new(params)
  end

  def create
    @group_params = group_params
    @group = Group.find(@group_params[:id])

    @user = @group.users.new(user_params)
    @user.params_for_device(device_params)
    if User.exists?(name: @user.name, email: @user.email, origin: @user.origin)
      @user = User.find_by_name(@user.name)
      render json: Error.conflict.merge(user: @user),
             status: 409
    else
      @user.save
      render json: @user
    end
  end

  def update
    @current_user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :origin)
  end

  def group_params
    params.require(:group).permit(:id)
  end

  def device_params
    params.require(:device).permit(:device_manufacturer, :device_model)
  end
end
