Rails.application.routes.draw do

  root "home#top"
  get 'home/about'

  get '/search' => 'search#search'

  devise_for :users

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
