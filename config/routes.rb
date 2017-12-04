Rails.application.routes.draw do


  resources :orders
  resources :packages

  resources :addresses

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"}
  devise_scope :user do
    get 'users/profile', to: 'users/registrations#profile', as: 'profile'
  end
  root to: "home#index"
end
