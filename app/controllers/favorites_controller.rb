class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    anime = Anime.find(params[:anime_id])
    favorite = current_user.favorites.new(anime_id: anime.id)
    favorite.save
    redirect_to anime_path(anime)
  end

  def destroy
    anime = Anime.find(params[:anime_id])
    favorite = current_user.favorites.find_by(anime_id: anime.id)
    favorite.destroy
    redirect_to anime_path(anime)
  end
end
