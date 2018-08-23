class ChangePriceToPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :price, :decimal, precision: 15, scale: 2
  end
end
