Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items, only: [:show , :edit, :new]
  resources :images, only: [:index]
  resources :users, only: [:new]
  resources :users_side, only: [:new , :show]
  resources :addresses, only: [:new, :create, :show, :edit, :update]
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

