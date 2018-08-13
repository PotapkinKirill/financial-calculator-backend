Rails.application.routes.draw do
  mount Payments => '/api'
  mount Categories => '/api'
end
