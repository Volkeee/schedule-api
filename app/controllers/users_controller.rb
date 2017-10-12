class UsersController < ApplicationController
  skip_before_action authenticate: :create
  def new
    @user = User.new
  end

  def create
    @group_params = group_params
    @group = Group.find(@group_params[:id])

    @user = @group.users.new(user_params)
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
    @group = Group.find(group_params[:id])

    @group.users.find_by(user_params[:name]).update(user_params)
    @group.users.save
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :origin)
  end

  def group_params
    params.require(:group).permit(:id)
  end
end
