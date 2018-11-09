class UpdateAvailableInventoryColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :available_inventory, :integer
  end
end
