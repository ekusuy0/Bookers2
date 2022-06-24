Rails.application.routes.draw do
  get 'searches/search'
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  get 'search' => 'searches#search'
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'follow' => 'relationships#follow',as: 'follow'
    get 'follower' => 'relationships#follower', as: 'follower'
  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end