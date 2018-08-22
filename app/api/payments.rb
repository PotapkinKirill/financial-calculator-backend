class Payments < Grape::API
  resources :payments do
    desc 'Get all the formatted payments'
    get do
      { payments: Payment.preview }
    end

    desc 'Add payment and category if needed'
    params do
      requires :category, type: String
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    post do
      {
        payment: Payment.add(params),
        category: Category.find_by(name: params[:category])
      }
    end

    desc 'Update payment and category if needed'
    params do
      requires :category, type: String
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    put ':id' do
      { payment: Payment.add(params) }
    end
  end
end
