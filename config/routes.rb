Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index]
  resources :scores, only: [:index]
  resources :games, only: [:new, :create]

  root to: 'users#index'

  get '/history', to: 'scores#index'
  get '/log',     to: 'games#new'
end
