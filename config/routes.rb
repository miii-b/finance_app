Rails.application.routes.draw do

  root 'root#index'
#  get 'categories/index'
 # get 'categories/edit'
 # get 'categories/new'
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   #root 'welcome#index'
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
