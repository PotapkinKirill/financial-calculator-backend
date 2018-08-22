class Incomes < Grape::API
  resources :incomes do
    desc 'Get all the formatted payments'
    get do
      { incomes: Income.preview }
    end

    desc 'Add income and category if needed'
    params do
      requires :category, type: String
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    post do
      {
        income: Income.add(params),
        category: Category.find_by(name: params[:category])
      }
    end

    desc 'Update payment and category if needed'
    params do
      requires :category, type: String
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    put ':id' do
      { income: Income.add(params) }
    end
  end
end
