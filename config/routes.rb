Rails.application.routes.draw do
  mount Categories => '/api'
  mount Payments => '/api'
  mount Incomes => '/api'
end
