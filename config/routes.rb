Rails.application.routes.draw do
  devise_for :users, path: 'devise'
  resources :patients, :users
  resources :doctors do
    resources :patients
  end
  
  root :to =>'pages#home'
  
  get '/appointment', to: 'pages#appointment'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
