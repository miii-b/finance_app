Rails.application.routes.draw do

  root 'accounts#index'
  resources :categories
  resources :transactions
  resources :accounts
  resources :users
  resources :logins
  resources :sessions
  get '/logout', to: 'logins#destroy'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
end
