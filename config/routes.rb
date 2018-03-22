Rails.application.routes.draw do
  devise_for :users, path: 'devise'
  # resources :patients do
  #   resources :doctors
  # end
  resources :doctors do
    resources :patients
  end
  resources :patients, :users
  
  root :to =>'pages#home'
  
  get '/appointment', to: 'pages#appointment'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
