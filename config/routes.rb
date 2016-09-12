Rails.application.routes.draw do


  root 'static_pages#index'

  get '/sessions/new', to: 'sessions#new', as: :sign_up
  post '/sessions/create', to: 'sessions#create', as: :sessions_create
  post '/sessions/destroy', to: 'sessions#destroy', as: :sessions_destroy


end
