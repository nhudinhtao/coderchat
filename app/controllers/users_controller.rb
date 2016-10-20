class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
    @user = @current_user
    @messages = @user.received_messages
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Account created."
    else
      render 'new'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
