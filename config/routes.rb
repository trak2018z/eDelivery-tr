Rails.application.routes.draw do




  resources :orders
  resources :packages

  resources :addresses
  resources :profiles

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations'}

  root to: 'home#index'
end
