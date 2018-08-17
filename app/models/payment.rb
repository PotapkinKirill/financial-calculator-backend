class Payment < ApplicationRecord
  belongs_to :category

  scope :selected_date, ->(date) {
    first_of_month = date.beginning_of_month
    end_of_month = date.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  def self.preview
    categories = Category.payment
    date = Date.current
    @payments = []
    categories.map do |category|
      category.payments.selected_date(date).map do |payment|
        @payments << payment_object(category, payment)
      end
    end
    @payments
  end

  def self.add(params)
    @category = Category.find_by(name: params[:category])
    @category ||= Category.create(name: params[:category], type_of_pay: 'payment')
    create_payment(@category, params[:price])
  end

  def self.create_payment(category, price)
    payment = category.payments.create(price: price)
    payment_object(category, payment)
  end

  def self.payment_object(category, payment)
    {
      id: payment.id,
      category: category.name,
      price: payment.price,
      created_at: payment.created_at
    }
  end

  def self.sum(payments, date)
    payments.selected_date(date).map(&:price).sum
  end
end
