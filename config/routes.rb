Rails.application.routes.draw do

  root "home#top"
  get 'home/about'
  get '/search' => 'search#search'

  devise_for :admins, controllers: {
    sessions:        "admins/sessions",  #admins/sessionsはコントローラー名
    passwords:       "admins/passwords",
    registrations:   "admins/registrations"
  }
  
  devise_for :users, controllers: {
    sessions:        "users/sessions",
    passwords:       "users/passwords",
    registrations:   "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :admins do
    resources :animes, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


