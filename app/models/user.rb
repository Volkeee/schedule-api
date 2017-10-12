class User < ApplicationRecord
  belongs_to :group
  has_many :tasks
  has_one :role
  require 'securerandom'
  before_create :set_auth_token

  def self.token_from_headers(token)
    User.find_by_auth_token(token)
  end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.delete('-')
  end
end
