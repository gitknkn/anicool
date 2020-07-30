class SearchController < ApplicationController

  def search
    @anime_column = params["search"]["anime_column"]
    @how = params["search"]["how"]
    @title_main = params["title_main"]
    @datas = search_for(@how, @anime_column, @title_main)
  end

  private
  def match(anime_column, title_main)
    if anime_column == 'title'
      Anime.where(title: title_main)
    elsif anime_column == 'main'
      Anime.where(main: title_main)
    else
      Anime.all
    end
  end

  def partical(anime_column, title_main)
    if anime_column == 'title'
      Anime.where("title LIKE ?", "%#{title_main}%")
    else anime_column == 'main'
      Anime.where("main LIKE ?", "%#{title_main}%")
    end
  end

  def search_for(how, anime_column, title_main)
    case how
      when 'match'
        match(anime_column, title_main)
      when 'partical'
        partical(anime_column, title_main)
    end
  end

end