Rails.application.routes.draw do
  devise_for :admins,skip: :all
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

  resources :admin, only: [:index,:create] do
    collection do 
      get "sms_confirmation"
      post "sms_confirmation" => "admin#sms_check"
      delete "sign_out"
    end
    resources :posts, except: :show
  end
end
