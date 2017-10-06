class TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.all
    render json: @tasks
  end

  def create
    @user = User.find(user_params[:name])
    if !@user.nil?
      @task = @user.tasks.create(task_params)
    else
      render json: Error.not_found, status: 404
    end
  end

  def update
    @user = User.find(user_params[:name])
    if @user.tasks.exists?(task_params['id'])
      @task = @user.tasks.update(task_params)
    else
      render json: Error.not_found, status: 404
      errors.add(:not_found, 'No such group with ID ' + params[:id])
    end
  end

  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def task_params
    params.require(:task).permit(:title, :text, :lesson_id, :date)
  end
end
