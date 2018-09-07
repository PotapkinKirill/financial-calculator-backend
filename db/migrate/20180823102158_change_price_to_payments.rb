class ChangePriceToPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :price, :float
  end
end
