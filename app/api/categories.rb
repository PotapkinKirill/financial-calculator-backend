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
    get :all do
      {
        categories: Category.all_with_sum(nil)
      }
    end
    post :all do
      {
        categories: Category.all_with_sum(params)
      }
    end
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
        category: Category.create(name: params[:category], type_of_pay: params[:type])
      }
    end
    post :update do
      {
        category: Category.update(name: params[:category])
      }
    end
    post :delete do
      Category.find(params[:id]).delete if params[:id].present?
    end
  end
end
