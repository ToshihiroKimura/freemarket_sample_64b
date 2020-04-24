Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items, only: [:index, :show , :edit, :new, :create] do
    collection do
      get 'category_children',defaults:{format:'json'}
      get 'category_grandchildren',defaults:{format:'json'}
    end
  end
  resources :items, only: [:show , :edit, :new] do
    member do
      get 'buy_confirmation'
      post 'payment'
      get 'buy_complete'
    end
end

  resources :images, only: [:index]
  resources :users, only: [:new, :show]
  resources :addresses, only: [:new, :create, :edit, :update]
  resources :cards, :cards_delate, only: [:index, :new, :show]do
    ENV['PAYJP_PRIVATE_KEY']
    ENV['PAYJP_KEY']
    collection do
      #payjpでトークン化を行う
      post 'pay', to: 'cards#pay'
      #カード削除
      post 'delete', to: 'cards#delete'
      #カード情報入力
      post 'show', to: 'cards#show'
    end
  end
end