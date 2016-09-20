Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links, only: [:index, :update]
    end
  end

  root 'static_pages#index'

  get '/sessions/new', to: 'sessions#new', as: :sign_up
  post '/sessions/create', to: 'sessions#create', as: :sessions_create
  delete '/sessions/destroy', to: 'sessions#destroy', as: :sessions_destroy
  get 'links/index', to: 'links#index', as: :links_index
  post 'link/create', to: 'links#create'
  get 'links/edit/:id', to: 'links#edit', as: :links_edit
  put 'links/update/:id', to: 'links#update', as: :links_update
end
