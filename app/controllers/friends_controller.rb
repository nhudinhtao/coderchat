class FriendsController < ApplicationController
  before_action :require_login

  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
    load_user
  end

  def create
    @friend = Friend.new friend_params
    if @friend.save
      flash[:success] = "Save to friends list successfully."
      redirect_to friends_path
    else
      flash.now[:error] = "Unsave to friends list, please try again."
      render 'new'
    end
    
  end

  def destroy
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  def friend_params
    params.require(:friend).permit(:user_id, :name, :email, :phone, :address)
  end
end
