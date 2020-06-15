class SearchController < ApplicationController

  def search
    @animes = Anime.search(params[:search])
  end

end
