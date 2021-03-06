class UsersController < ApplicationController
  # before_action :set_user, only: [:show]
  # before_action :redirect_session, only: [:show]
  # before_action :login_new, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(session[:user_id])
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def redirect_session
    if @user.id != current_user.id 
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def login_new
    if logged_in? && !current_user
      redirect_to user_path(current_user)
    end
  end
end
