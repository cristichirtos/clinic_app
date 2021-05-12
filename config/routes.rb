Rails.application.routes.draw do
  get 'consultations/index'
  get 'patients/index'
  get 'users/new'
  root 'application#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  resources :patients
  resources :consultations
  resources :users
  resources :doctors, path: 'users'
  resources :admins, path: 'users'
  resources :secretaries, path: 'users'
end
