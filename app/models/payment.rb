class Payment < ApplicationRecord
  belongs_to :category

  scope :current_month, -> {
    first_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  def self.main_page
    @categories = Category.where(type_of_pay: 'payment')
    @categories.map do |category|
      payment_object(category)
    end
  end

  def self.add(params)
    @category = Category.create(name: params[:category], type_of_pay: 'payment')
    create_payment(@category, params)
  end

  def self.update(params)
    @category = Category.find_by(name: params[:category])
    create_payment(@category, params)
  end

  def self.create_payment(category, params)
    category.payments.create(price: params[:price])
    payment_object(category)
  end

  def self.payment_object(category)
    {
      id: category.id,
      category: category.name,
      price: category.payments.last.price,
      sum: category.payments.current_month.map(&:price).sum
    }
  end
end
