class Token < ApplicationRecord
  belongs_to :user
  before_create :generate_auth_token

  def self.user_by_token
    User.find_by_auth_token(self)
  end

  def generate_auth_token
    self.token= SecureRandom.uuid.delete('-')
  end
end