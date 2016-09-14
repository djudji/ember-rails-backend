Rails.application.routes.draw do
  resources :contacts
  resources :companies
  root to: 'root#index'
end
