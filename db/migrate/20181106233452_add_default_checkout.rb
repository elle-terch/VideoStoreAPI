class AddDefaultCheckout < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkout, :date, :default => Date.today 
  end
end
