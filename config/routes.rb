Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :users
  resource :credit_counter, only: [:create]
  resources :bundles
end
