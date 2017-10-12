class ChangeNameOfLastToken < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :last_token, :auth_token
  end
end
