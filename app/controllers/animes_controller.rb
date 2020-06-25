class AnimesController < ApplicationController
  before_action :authenticate_user!, except: [:index] #indexのみ非ログインでも、許可

  def new
    @anime = Anime.new
  end

  def create
    @anime = Anime.new(anime_params)
    # @anime.type = Anime.params[:type]
    @anime.user_id = current_user.id
    if @anime.save
      redirect_to animes_path, notice: "投稿が完了しました！"
    else
      render :new
    end
  end

  def index
    @animes = Anime.order(updated_at: :desc).page(params[:page]).per(9)
  end

  def show
    @anime = Anime.find(params[:id])
    @user = @anime.user 
    @comments = @anime.anime_comments.order(created_at: :desc)
    @comment = @anime.anime_comments.build
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
      redirect_to anime_path(@anime.id), notice: "投稿を編集しました！"
    else
      render "edit"
    end
  end

  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    redirect_to animes_path, notice: "投稿を削除しました！"
  end

  def search
    @animes = Anime.search(params[:search])
  end

  private
  def anime_params
    params.require(:anime).permit(:title, :main, :subbody, :image)
  end

end
