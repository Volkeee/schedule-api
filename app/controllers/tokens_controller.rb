class TokensController < ApplicationController

  def show
    render json: @current_user.tokens.order('created_at').last
  end

  def index
    render json: @current_user.tokens
  end

  def create
    if @current_user.tokens.find_by(device_params).nil?
      @current_user.tokens.create(device_params)
      @current_user.save
      render status: 200
    else

      render json: Error.conflict, status: 409
    end
  end

  def destroy
    if @current_user.tokens.find_by(token: request.headers['Authorization']).nil?
      render json: Error.not_found, status: 400
    else
      @token = @current_user.tokens.find_by(token: request.headers['Authorization'])
      if @token['validity']
        @token['validity'] = false
        @token.save
      else
        @error = Error.conflict
        @error[:response][:description] = 'Token is already invalid'
        render json: @error, status: 409
      end
    end
  end

  def destroy_all
    @current_user
  end

  def validate

  end

  private

  def device_params
    params.require(:device).permit(:device_manufacturer, :device_model)
  end
end
