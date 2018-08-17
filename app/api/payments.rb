class Payments < Grape::API
  version 'v1', using: :path
  format :json
  rescue_from :all

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get post]
    end
  end

  resources :payment do
    before do
      header 'Access-Control-Allow-Origin', '*'
    end
    post :all do
      {
        payments: Payment.preview
      }
    end
    post :charts do
      {
        payments: Payment.charts(params)
      }
    end
    post :add do
      {
        payment: Payment.add(params),
        category: Category.find_by(name: params[:category])
      }
    end
    post :update do
      {
        payment: Payment.add(params)
      }
    end
  end
end
