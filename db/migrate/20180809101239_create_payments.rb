class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :payment_category_id
      t.string :price

      t.timestamps
    end
  end
end
