class PaymentCategory < ApplicationRecord
  has_many :payments
end
