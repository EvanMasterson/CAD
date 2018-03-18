Rails.application.routes.draw do
  devise_for :users
  resources :patients do
    resources :doctors
  end
  resources :doctors do
    resources :patients
  end
  
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
