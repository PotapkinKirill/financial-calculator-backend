class API < Grape::API
  version 'v1', using: :path
  format :json
  rescue_from :all

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get post put delete options]
    end
  end

  mount Categories
  mount Payments
  mount Incomes
  add_swagger_documentation
end
