Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admins
  devise_for :users
  root to: 'pages#home'
  get 'auth/callback', to: 'companies#auth_callback'
  get 'apis', to: 'pages#apis'
  resources :companies do
    member do
      post :provision
      get :auth_callback
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
    end
  end
end
