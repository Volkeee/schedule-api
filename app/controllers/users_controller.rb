class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @group_params = group_params
    @group = Group.find(@group_params[:id])

    @user = @group.users.new(user_params)
    if User.exists?(name: @user.name, email: @user.email)
      @user = User.find_by_name(@user.name)
      render json: Error.conflict.merge(user: @user.attributes.except('created_at', 'updated_at')),
             status: 409
    else
      @user.save
      render json: @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def group_params
    params.require(:group).permit(:id)
  end
end
