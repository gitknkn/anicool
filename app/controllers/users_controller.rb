class UsersController < ApplicationController

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @animes = @user.animes.order(updated_at: :desc).page(params[:page]).per(9)
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集しました！"
      redirect_to user_path(@user.id)
    else 
      render :edit
    end
  end

  def following # @userがフォローしているユーザー
    @user = User.find(params[:id])
    @users = @user.following
    render 'following'
  end

  def followers # @userをフォローしているユーザー
      @user = User.find(params[:id])
      @users = @user.followers
      render 'followers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :my_introdution, :my_photo)
  end
end
