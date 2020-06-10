class AnimeCommentsController < ApplicationController
  before_action :authenticate_user! #ログインユーザーのみアクセスを許可

  def create
    @anime = Anime.find(params[:anime_id])
    @comment = @anime.anime_comments.build(anime_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしましました"
      redirect_back(fallback_location: anime_path(anime))
    else
      flash[:alert]
      render template: "animes/show"
    end
  end

  def edit
    @anime = Anime.find(params[:anime_id])
    @comment = AnimeComment.find(params[:id])
  end

  def update
    @anime = Anime.find(params[:anime_id])
    @comment = AnimeComment.find(params[:id])
    if @comment.update(anime_comment_params)
      redirect_to anime_path(params[:anime_id])
    else
      render "edit"
    end
  end

  def destroy
    @anime = Anime.find(params[:anime_id])
    @comment = AnimeComment.find(params[:id])
    @comment.user_id = current_user.id
    @comment.destroy
    redirect_to anime_path(params[:anime_id])
  end

  private
  def anime_comment_params
    params.require(:anime_comment).permit(:comment, :user_id, :anime_id)
  end
end
