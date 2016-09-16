Rails.application.routes.draw do
  root to: 'root#index'

  resources :notes
  resources :offers
  resources :tasks
  resources :projects
  resources :contacts
  resources :companies
  resources :authorizations, only: [:create]
end
