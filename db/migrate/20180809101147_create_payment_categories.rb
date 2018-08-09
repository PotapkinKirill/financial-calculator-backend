class CreatePaymentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end