class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @anime = Anime.find(params[:anime_id])
    favorite = current_user.favorites.new(anime_id: @anime.id) #上記のAnimeモデルの中から.idを限定して選択している。
    favorite.save
  end

  def destroy
    @anime = Anime.find(params[:anime_id])
    favorite = current_user.favorites.find_by(anime_id: @anime.id)
    favorite.destroy
  end
end
