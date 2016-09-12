Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/new'

  root 'static_pages#index'

  # get '/sign_up', to: 


end
