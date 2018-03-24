Rails.application.routes.draw do
  devise_for :users, path: 'devise'
  resources :patients, :users
  resources :doctors do
    resources :patients
  end
  
  root :to =>'pages#home'
  
  get '/appointment', to: 'pages#appointment'
  get '/add_patient', to: 'patients#add_patient_to_doctor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
