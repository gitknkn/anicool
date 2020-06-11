class AnimeCommentsController < ApplicationController
  before_action :authenticate_user! #ログインユーザーのみアクセスを許可

  def create
    @anime = Anime.find(params[:anime_id])
    @comment = @anime.anime_comments.build(anime_comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @anime = Anime.find(params[:anime_id]) #rails routes確認内容
    @comment = AnimeComment.find(params[:id]) #rails routes確認内容
    @comment.user_id = current_user.id
    @comment.destroy
  end

  private
  def anime_comment_params
    params.require(:anime_comment).permit(:comment, :user_id, :anime_id)
  end
end


# if @comment.save
#   flash[:success] = "コメントしましました"
#   redirect_back(fallback_location: anime_path(anime))
# else
#   flash[:alert]
#   render template: "animes/show"
# end


# redirect_to anime_path(params[:anime_id])
