class Income < ApplicationRecord
  belongs_to :category

  scope :selected_date, ->(date) {
    first_of_month = date.beginning_of_month
    end_of_month = date.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  def self.preview
    categories = Category.income
    date = Date.current
    @incomes = []
    categories.map do |category|
      category.incomes.selected_date(date).map do |income|
        @incomes << payment_object(category, income)
      end
    end
    @incomes
  end

  def self.add(params)
    @category = Category.find_by(name: params[:category])
    @category ||= Category.create(name: params[:category], type_of_pay: 'income')
    create_payment(@category, params[:price])
  end

  def self.create_payment(category, price)
    income = category.incomes.create(price: price)
    payment_object(category, income)
  end

  def self.payment_object(category, income)
    {
      id: income.id,
      category: category.name,
      price: income.price,
      created_at: income.created_at
    }
  end

  def self.sum(incomes, date)
    incomes.selected_date(date).map(&:price).sum
  end
end
