Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top_page#index'

  resources :posts, only: :show do
    collection do   
      get "all"
      get "fishing"
      get "audio"
      get "tech"
      get "others"
    end
  end
end
