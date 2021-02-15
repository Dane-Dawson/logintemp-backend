Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  post '/auto_login', to: 'auth#auto_login'
  get '/logged_in', to: 'application#logged_in?'
  get '/things', to: 'things#index'
end
