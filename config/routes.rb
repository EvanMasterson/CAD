Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :admins, path: 'admins'
  # resources :patients do
  #   resources :doctors
  # end
  # resources :doctors do
  #   resources :patients
  # end
  
  root :to =>'pages#home'
  
  get '/appointment', to: 'pages#appointment'
  get '/patients', to: 'patients#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
