class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :category, index: true
      t.integer :price

      t.timestamps
    end
  end
end
