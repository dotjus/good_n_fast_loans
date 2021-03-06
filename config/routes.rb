Rails.application.routes.draw do
  resources :listings
  get 'listings/borrow/:id', to: 'listings#borrow', as: 'borrow' 
  get 'listings/borrowed/:id', to: 'listings#borrowed', as: 'borrowed' 
  devise_for :users

  get 'pages/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/pages/my_listings', to: 'pages#my_listings', as: 'my_listings'
  get '/pages/my_hires', to: 'pages#my_hires', as: 'my_hires'
  post '/listings/:id/pay', to: 'listings#pay', as: 'pay'
  get '/listings/:id/success', to: 'listings#pay_success', as: 'pay_success'
  get '/listings/:id/cancel', to: 'listings#pay_cancel', as: 'pay_cancel'

  root to: "pages#home"

end
