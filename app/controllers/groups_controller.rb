class GroupsController < ApplicationController
  prepend SimpleCommand

  def index
    @group = Group.all
    render json: @group
  end

  def create
    @group = Group.new(group_params)

    @group.save
  end

  def show
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      render json: @group
    else
      render json: Error.not_found, status: 404
      errors.add(:not_found, 'No such group with ID ' + params[:id])
    end
  end

  private

  def group_params
    params.require(:groups).permit(:has_subgroups, :name)
  end
end
