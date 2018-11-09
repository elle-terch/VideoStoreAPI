class AddAnotherColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :available_inventory, :integer, :default => 10
  end
end
