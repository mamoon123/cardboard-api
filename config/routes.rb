Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  apipie
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      post 'auth/register', to: 'users#register'
      post 'auth/login', to: 'users#login'
      post 'auth/forgot_password', to: 'users#forgot_password'
      post 'auth/update_password', to: 'users#update_password'

      resources :cardboard_types
      resources :orders
    end
  end
end
