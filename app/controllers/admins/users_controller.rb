class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admins_users_path
  end
end
