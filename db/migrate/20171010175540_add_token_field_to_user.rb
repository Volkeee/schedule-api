class AddTokenFieldToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_token, :string
  end
end
