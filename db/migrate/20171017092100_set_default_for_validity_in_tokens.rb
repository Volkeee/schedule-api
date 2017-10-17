class SetDefaultForValidityInTokens < ActiveRecord::Migration[5.1]
  def change
    remove_column :tokens, :validity
    add_column :tokens, :validity, :boolean, default: true
  end
end
