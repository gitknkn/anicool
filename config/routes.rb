Rails.application.routes.draw do

  root "home#top"
  get 'home/about'
  get '/search' => 'search#search'
  
  devise_for :users, controllers: {
    sessions:        "users/sessions",
    passwords:       "users/passwords",
    registrations:   "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member  do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :animes do
    resource :favorites, only: [:create, :destroy]
    resources :anime_comments, only: [:create, :destroy]
  end

  namespace :admins do
    resources :animes, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
  end

  # seedに変更の為、devise使用しない(admins側)
  # devise_for :admins, controllers: {
  #   sessions:        "admins/sessions",  #admins/sessionsはコントローラー名
  #   passwords:       "admins/password",  
  #   registrations:   "admins/registrations"  
  # }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


