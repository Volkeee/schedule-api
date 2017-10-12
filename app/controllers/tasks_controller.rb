class TasksController < ApplicationController
  def index
    @user = User.token_from_headers(token)
    @tasks = @user.tasks.all
    render json: @tasks
  end

  def create
    @user = User.token_from_headers(token)
    if !@user.nil?
      @json = task_params
      @json.as_json.each do |k, v|
        @user.tasks.create(v)
      end
      # @user.tasks.create(task_params)
    else
      render json: Error.not_found, status: 404
    end
  end

  def update
    @user = User.token_from_headers(token)
    if @user.tasks.exists?(task_params['id'])
      @task = @user.tasks.update(task_params)
    else
      render json: Error.not_found, status: 404
      errors.add(:not_found, 'No such task with ID ' + params[:id] +
          'that belongs to user ' + @user.name)
    end
  end

  def show
    if !Task.exists?(params[:id])
      @user = User.find(params[:user_id])
      @task = @user.tasks.find(params[:id])
      render json: @task
    else
      render json: Error.not_found, status: 404
    end
  end

  private

  def task_params
    params.permit(tasks: [:title, :description, :lesson_name, :date])
  end

  def token
    request.headers['Authorization'].remove('Token token=')
  end
end
