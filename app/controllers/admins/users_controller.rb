class Admins::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admins_users_path
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
