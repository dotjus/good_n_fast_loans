Rails.application.routes.draw do
  resources :listings
  get 'listings/borrow/:id', to: 'listings#borrow', as: 'borrow' 
  devise_for :users
  get 'pages/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/pages/my_listings', to: 'pages#my_listings', as: 'my_listings'
  get '/pages/my_hires', to: 'pages#my_hires', as: 'my_hires'
  root to: "pages#home"

end
