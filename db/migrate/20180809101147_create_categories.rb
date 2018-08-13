class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.column :type_of_pay, :integer, default: 0

      t.timestamps
    end
  end
end
