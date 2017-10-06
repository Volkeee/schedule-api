class ChangeTypeOfHasSubgroups < ActiveRecord::Migration[5.1]
  def change
    change_column :groups, :has_subgroups, :boolean
  end
end
