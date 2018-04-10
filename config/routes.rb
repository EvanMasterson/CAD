Rails.application.routes.draw do
  get 'search/index'

  devise_for :users, path: 'devise'
  resources :patients, :users
  resources :doctors do
    resources :patients
  end
  
  root :to =>'pages#home'
  
  get '/appointment', to: 'pages#appointment'
  get '/profile', to: 'pages#profile'
  get '/add_patient', to: 'patients#add_patient_to_doctor'
  get '/search', to: 'search#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
