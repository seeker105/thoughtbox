Rails.application.routes.draw do

  root 'static_pages#index'

  get '/sessions/new', to: 'sessions#new', as: :sign_up
  post '/sessions/create', to: 'sessions#create', as: :sessions_create
  delete '/sessions/destroy', to: 'sessions#destroy', as: :sessions_destroy
  get 'links/index', to: 'links#index', as: :links_index
  post 'link/create', to: 'links#create'
end
