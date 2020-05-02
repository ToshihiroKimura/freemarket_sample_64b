Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items  do
    collection do
      get 'category_children',defaults:{format:'json'}
      get 'category_grandchildren',defaults:{format:'json'}
      get 'items/category_children',defaults:{format:'json'}
      get 'items/category_grandchildren',defaults:{format:'json'}

    end
  end
  resources :items, only: [:show , :edit, :new] do
    member do
      get 'buy_confirmation'
      post 'payment'
      get 'buy_complete'
    end
end

  #resources :images, only: [:index]
  resources :users, only: [:new, :show]
  resources :addresses, only: [:new, :create, :edit, :update]
  resources :cards, only: [:new, :show]do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end