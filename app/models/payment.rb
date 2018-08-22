class Payment < ApplicationRecord
  belongs_to :category

  scope :selected_date, ->(date) {
    first_of_month = date.beginning_of_month
    end_of_month = date.end_of_month
    where(created_at: first_of_month..end_of_month)
  }

  extend PaymentHelper
end
