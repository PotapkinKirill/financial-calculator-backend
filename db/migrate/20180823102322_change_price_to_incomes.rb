class ChangePriceToIncomes < ActiveRecord::Migration[5.2]
  def change
    change_column :incomes, :price, :float
  end
end
