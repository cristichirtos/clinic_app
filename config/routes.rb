Rails.application.routes.draw do
  root 'application#home'

  get 'consultations/index'
  get 'patients/index'
  get 'users/new'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  get    '/signup', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'

  resources :patients
  resources :consultations do 
    get :check_in, on: :member
  end
  resources :users
  resources :doctors,     path: 'users'
  resources :admins,      path: 'users'
  resources :secretaries, path: 'users'

  mount ActionCable.server => '/cable'
end
