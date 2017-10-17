class Token < ApplicationRecord
  belongs_to :user

  def self.user_by_token
    User.find_by_auth_token(self)
  end
end
