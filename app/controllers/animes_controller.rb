class AnimesController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def new
    @anime = Anime.new
  end

  def create
    @anime = Anime.new(anime_params)
    @anime.user_id = current_user.id
    @anime.save
    redirect_to animes_path
  end

  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find(params[:id])
    # @user = Anime.user
  end

  def edit
    @anime = Anime.find(params[:id])
    if @anime.user != current_user
      redeirct_to animes_path
    end
  end

  def update
    @anime = Anime.find(params[:id])
    if @anime.update(anime_params)
      redirect_to anime_path(@anime.id)
    else
      render "edit"
    end
  end

  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    redirect_to animes_path
  end

  private
  def anime_params
    params.require(:anime).permit(:title, :main, :subbody, :image)
  end

end
