class Admins::AnimesController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.order(updated_at: :desc).page(params[:page]).per(15)
    @animes = Anime.all
  end

  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    redirect_to admins_animes_path
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
