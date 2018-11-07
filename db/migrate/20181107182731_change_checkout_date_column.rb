class ChangeCheckoutDateColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkout, :date
  end
end
