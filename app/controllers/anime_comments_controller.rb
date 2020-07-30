class AnimeCommentsController < ApplicationController
  before_action :authenticate_user! #ログインユーザーのみアクセスを許可

  def create
    @anime = Anime.find(params[:anime_id])
    @comment = @anime.anime_comments.build(anime_comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @anime.anime_comments.order(created_at: :desc)
  end

  def destroy
    @anime = Anime.find(params[:anime_id]) #rails routes確認内容
    @comment = AnimeComment.find(params[:id]) #rails routes確認内容
    @comment.user_id = current_user.id
    @comment.destroy
    @comments = @anime.anime_comments.order(created_at: :desc)
  end

  private
  def anime_comment_params
    params.require(:anime_comment).permit(:comment, :user_id, :anime_id)
  end
end