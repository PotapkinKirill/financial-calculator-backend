class Category < ApplicationRecord
  validates :name, uniqueness: {scope: :type_of_pay}
  has_many :payments
  has_many :incomes

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

  def delete
    @other = Category.find_by(name: 'Other', type_of_pay: type_of_pay)
    payments.map { |payment| payment.update(category_id: @other.id) }
    incomes.map { |income| income.update(category_id: @other.id) }
    super
  end
end
