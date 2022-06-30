Rails.application.routes.draw do
  get 'searches/search'
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  get 'search' => 'searches#search'
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    get "search", to: "users#search"
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :groups do
    get "join" => "groups#join"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end