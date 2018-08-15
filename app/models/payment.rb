class Payment < ApplicationRecord
  belongs_to :category

  scope :selected_date, ->(date) {
    first_of_month = date.beginning_of_month
    end_of_month = date.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  def self.main_page(params)
    @categories = Category.payment
    @categories.map do |category|
      if params[:year] && params[:month]
        date = Date.new(params[:year], params[:month] + 1)
        payment_object(category, date)
      else
        payment_object(category)
      end
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

  def self.payment_object(category, date = Date.current)
    {
      id: category.id,
      category: category.name,
      price: category.payments.last.price,
      sum: category.payments.selected_date(date).map(&:price).sum
    }
  end
end
