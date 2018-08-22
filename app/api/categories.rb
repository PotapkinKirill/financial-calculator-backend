class Categories < Grape::API
  resources :categories do
    desc 'Get all categories with type "payment"'
    get :payment do
      { categories: Category.payment }
    end

    desc 'Get all categories with type "income"'
    get :income do
      { categories: Category.income }
    end

    desc 'Get all categories with sum for current or selected month'
    params do
      requires :month, type: Integer
      requires :year, type: Integer
    end
    get :sum do
      { categories: Category.all_with_sum(params) }
    end

    desc 'Get all categories with sum for current or selected month'
    get do
      { categories: Category.all }
    end

    desc 'Add category'
    params do
      requires :category, type: String
      requires :type, type: String, values: %w[income payment]
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    post do
      {
        category: Category.create(name: params[:category],
                                  type_of_pay: params[:type],
                                  color: params[:color])
      }
    end

    desc 'Update category by id'
    params do
      requires :id, type: Integer
      requires :category, type: String
      optional :color, type: String, regexp: /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
    end
    put ':id' do
      Category.find(params[:id]).update(name: params[:category],
                                        color: params[:color])
      { category: Category.find(params[:id]) }
    end

    desc 'Delete category by id'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      Category.find(params[:id]).delete.destroyed?
    end
  end
end
