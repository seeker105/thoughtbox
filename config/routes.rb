Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links, only: [:index, :update]
    end
  end

  root 'static_pages#index'

  get '/sessions/new', to: 'sessions#new', as: :login
  post '/sessions/create', to: 'sessions#create', as: :sessions_create
  get '/users/new', to: 'users#new', as: :sign_up
  post '/users/create', to: 'users#create', as: :users_create
  delete '/sessions/destroy', to: 'sessions#destroy', as: :sessions_destroy
  get 'links/index', to: 'links#index', as: :links_index
  post 'link/create', to: 'links#create'
  get 'links/edit/:id', to: 'links#edit', as: :links_edit
  put 'links/update/:id', to: 'links#update', as: :links_update
end
