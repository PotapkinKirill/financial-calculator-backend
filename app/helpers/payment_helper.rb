module PaymentHelper
  def preview
    categories = Category.send(type_of_payment)
    date = Date.current
    @payments = []
    categories.map do |category|
      category.send(category_type).selected_date(date).map do |payment|
        @payments << payment_object(category, payment)
      end
    end
    @payments
  end

  def add(params)
    Category.create_with(color: params[:color]) if params[:color]
    @category = Category.find_or_create_by(name: params[:category],
                                           type_of_pay: type_of_payment)
    create_payment(@category, params[:price])
  end

  def create_payment(category, price)
    payment = category.send(category_type).create(price: price)
    payment_object(category, payment)
  end

  def payment_object(category, payment)
    {
      id: payment.id,
      category: category.name,
      price: payment.price,
      created_at: payment.created_at
    }
  end

  def sum(payments)
    payments.selected_date(date).map(&:price).sum
  end

  def type_of_payment
    name.downcase
  end

  def category_type
    name.downcase + 's'
  end
end
