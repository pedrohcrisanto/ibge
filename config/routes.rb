Rails.application.routes.draw do
  resources :addresses
  

  # mudar get para post
  post "data/fill", to: "addresses#fill"
  
  devise_for :users

  
  root 'addresses#new'
end
