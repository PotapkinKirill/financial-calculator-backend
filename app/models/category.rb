class Category < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :payments, dependent: :destroy
  has_many :incomes, dependent: :destroy

  enum type_of_pay: { payment: 0, income: 1 }

  def self.all_with_sum(params)
    categories = Category.all
    date = if params && params[:year] && params[:month]
             Date.new(params[:year], params[:month] + 1)
           else
             Date.current
           end
    categories.map do |category|
      sum = sum(category.payments, date) + sum(category.incomes, date)
      add_sum(category, sum)
    end
  end

  def self.sum(payments, date)
    payments.selected_date(date).map(&:price).sum
  end

  def self.add_sum(category, sum)
    category = category.as_json
    category[:sum] = sum
    category
  end
end
