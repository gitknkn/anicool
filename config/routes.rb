Rails.application.routes.draw do

  root "home#top"

  devise_for :users

  resources :users, only: [:show]
  resources :animes do
    resource :favorites, only: [:create, :destroy]
    resources :anime_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
