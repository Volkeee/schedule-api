class User < ApplicationRecord
  belongs_to :group
  has_many :tasks
  has_many :tokens
  has_one :role
  require 'securerandom'
  after_create :set_auth_token

  def params_for_device(params)
    @parameters = params
  end

  def self.token_from_headers(token)
    @token = Token.find_by(token: token)
    @user = User.find(@token.user_id)
    @user
  end

  private

  def device_is_new
    if !Token.find_by(device_manufacturer: @parameters['device_manufacturer'],
                      device_model: @parameters['device_model']).nil?
      true
    else
      false
    end
  end

  def set_auth_token
    return if tokens.all.where(validity: true).any?
    if device_is_new
      tokens.create(generate_auth_token)
    else
      Token.find_by(device_manufacturer: @parameters['device_manufacturer'],
                    device_model: @parameters['device_model'])
    end
  end

  def generate_auth_token
    @hash = { token: '',
              device_manufacturer: @parameters['device_manufacturer'],
              device_model: @parameters['device_model'] }
  end
end
