class Income < ApplicationRecord
  belongs_to :category

  scope :current_month, -> {
    first_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  def self.main_page
    @categories = Category.income
    @categories.map do |category|
      payment_object(category)
    end
  end

  def self.add(params)
    @category = Category.create(name: params[:category], type_of_pay: 'income')
    create_payment(@category, params)
  end

  def self.update(params)
    @category = Category.find_by(name: params[:category])
    create_payment(@category, params)
  end

  def self.create_payment(category, params)
    category.incomes.create(price: params[:price])
    payment_object(category)
  end

  def self.payment_object(category)
    {
      id: category.id,
      category: category.name,
      price: category.incomes.last.price,
      sum: category.incomes.current_month.map(&:price).sum
    }
  end
end
