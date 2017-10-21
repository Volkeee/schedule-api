class TokensController < ApplicationController

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
    if @current_user.tokens.find_by(device_params).nil?
      render json: Error.not_found, status: 400
    else
      @token = @current_user.tokens.find_by(device_params).update(validity: false)
      render status: 200
    end
  end

  def destroy_all
    @current_user
  end

  private

  def device_params
    params.require(:device).permit(:device_manufacturer, :device_model)
  end
end
