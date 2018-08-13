class Categories < Grape::API
  version 'v1', using: :path
  format :json
  rescue_from :all

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get post]
    end
  end

  resources :categories do
    get :payments do
      {
        categories: Category.payment
      }
    end
    get :incomes do
      {
        categories: Category.income
      }
    end
  end
end
