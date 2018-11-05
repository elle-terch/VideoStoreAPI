class AddDefaultCheckinDate < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkin, :date, :default => nil 
  end
end
