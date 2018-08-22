class Category < ApplicationRecord
  validates :name, uniqueness: { scope: :type_of_pay }
  has_many :payments
  has_many :incomes
  attribute :color, :string, default: -> { generate_color }

  enum type_of_pay: { payment: 0, income: 1 }

  class << self
    def all_with_sum(params = nil)
      categories = Category.all
      date = Date.current
      date = Date.new(params[:year], params[:month] + 1) if params.present?
      categories.map do |category|
        sum = sum(category.payments, date) + sum(category.incomes, date)
        add_sum(category, sum)
      end
    end

    def add(params)
      category = Category.new(name: params[:category],
                              type_of_pay: params[:type])
      if params[:color]
        category.update(color: params[:color])
      else
        category.save!
      end
      category
    end

    def sum(payments, date)
      payments.selected_date(date).map(&:price).sum
    end

    def add_sum(category, sum)
      category = category.as_json
      category[:sum] = sum
      category
    end

    def generate_color
      "##{format('%06x', rand * 0xffffff)}"
    end
  end

  def delete
    @other = Category.find_by(name: 'Other', type_of_pay: type_of_pay)
    payments.map { |payment| payment.update(category_id: @other.id) }
    incomes.map { |income| income.update(category_id: @other.id) }
    super
  end
end
