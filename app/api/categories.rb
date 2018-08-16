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
    post :add do
      {
        category: Category.create(name: params[:name], type_of_pay: params[:type])
      }
    end
    post :update do
      {
        category: Category.update(name: params[:name])
      }
    end
    post :delete do
      Category.find(params[:id]).delete if params[:id].present?
    end
  end
end
