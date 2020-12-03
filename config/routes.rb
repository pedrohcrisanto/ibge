Rails.application.routes.draw do
  resources :addresses
  
  get "data/fill", to: "addresses#fill"
  
  devise_for :users

  root 'addresses#new'
end
