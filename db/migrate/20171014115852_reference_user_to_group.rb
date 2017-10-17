class ReferenceUserToGroup < ActiveRecord::Migration[5.1]
  def change
    # remove_column :users, :group_id
    add_reference :users, :group, foreign_key: true, index: true
  end
end
