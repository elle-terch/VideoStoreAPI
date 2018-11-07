class ChangeCheckoutAgain < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkout, :date, :default => nil 

  end
end
