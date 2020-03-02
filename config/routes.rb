Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :trip, only: [:show, :index, :new, :create, :delete]
  # Dashboard
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'form', to: 'pages#form', as: 'form'

end
