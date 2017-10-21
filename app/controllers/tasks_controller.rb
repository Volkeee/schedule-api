class TasksController < ApplicationController
  def index
    @tasks = @current_user.tasks.all
    render json: @tasks
  end

  def create
    if !@current_user.nil?
      @json = task_params
      @json.as_json.each do |_k, v|
        @current_user.tasks.create(v)
      end
      @current_user.save
      # @user.tasks.create(task_params)
    else
      render json: Error.not_found, status: 404
    end
  end

  def update
    if @current_user.tasks.exists?(task_params['id'])
      @task = @current_user.tasks.update(task_params)
    else
      render json: Error.not_found, status: 404
      errors.add(:not_found, 'No such task with ID ' + params[:id] +
          'that belongs to user ' + @current_user.name)
    end
  end

  def show
    if !Task.exists?(params[:id])
      @task = @current_user.tasks.find(params[:id])
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
    request.headers['Authorization'].remove('Token ')
  end
end
