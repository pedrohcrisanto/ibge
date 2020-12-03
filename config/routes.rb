Rails.application.routes.draw do
  resources :addresses
  get "data/fill", to: "addresses#fill"
  devise_for :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
