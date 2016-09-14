Rails.application.routes.draw do
  resources :offers
  resources :tasks
  resources :projects
  resources :contacts
  resources :companies
  root to: 'root#index'
end
