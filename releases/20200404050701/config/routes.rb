Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  root "items#index"
  resources :items, only: [:index, :show , :edit, :new, :create]
  resources :images, only: [:index]
  resources :users, only: [:new]
  resources :addresses, only: [:new, :create, :show, :edit, :update]
end
