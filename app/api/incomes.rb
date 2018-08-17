class Incomes < Grape::API
  version 'v1', using: :path
  format :json
  rescue_from :all

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get post]
    end
  end

  resources :income do
    before do
      header 'Access-Control-Allow-Origin', '*'
    end
    post :all do
      {
        incomes: Income.preview
      }
    end
    post :charts do
      {
        incomes: Income.charts(params)
      }
    end
    post :add do
      {
        income: Income.add(params),
        category: Category.find_by(name: params[:category])
      }
    end
    post :update do
      {
        income: Income.add(params)
      }
    end
  end
end
