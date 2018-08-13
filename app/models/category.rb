class Category < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :payments, dependent: :destroy
  has_many :incomes

  enum type_of_pay: { payment: 0, income: 1 }
end
