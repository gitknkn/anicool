class SearchController < ApplicationController

  # def search
  #   @animes = Anime.search(params[:search])
  # end

  def search
    @anime = params["search"]["anime"]
    @how = params["search"]["how"]
    @title_main = params["title_main"]
    @datas = search_for(@how, @anime, @title_main)
  end

  private
  def match(anime, title_main)
    if anime == 'title'
      Anime.where(title: title_main)
    else anime == 'main'
      Anime.where(main: title_main)
    end
  end

  def partical(anime, title_main)
    if anime == 'title'
      Anime.where("title LIKE ?", "%#{title_main}%")
    else anime == 'main'
      Anime.where("main LIKE ?", "%#{title_main}%")
    end
  end

  def search_for(how, anime, title_main)
    case how
      when 'match'
        match(anime, title_main)
      when 'partical'
        partical(anime, title_main)
    end
  end

end