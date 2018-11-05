class UpdateRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checkout, :date
    add_column :rentals, :checkin, :date
  end
end
