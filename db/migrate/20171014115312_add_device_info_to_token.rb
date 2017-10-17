class AddDeviceInfoToToken < ActiveRecord::Migration[5.1]
  def change
    add_column :tokens, :device_manufacturer, :string
    add_column :tokens, :device_model, :string
  end
end
