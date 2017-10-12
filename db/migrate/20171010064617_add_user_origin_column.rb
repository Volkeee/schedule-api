class AddUserOriginColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :origin, :string
  end
end
