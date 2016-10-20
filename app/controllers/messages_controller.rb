class MessagesController < ApplicationController
  before_action :require_login, except: [:new]

  def index
    received
  end

  def new
    load_user
    @message = Message.new
    @users = User.all
  end

  def create
    load_user
    @message = @user.sent_messages.build message_params
    if @message.save
      redirect_to sent_messages_path
    else
      render 'new'
    end
  end

  def show
    @message = Message.find params[:id]
    if Message.unread? && current_user == @message.recipient
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @messages = @user.sent_messages
  end

  def received
    load_user
    @messages = @user.received_messages
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
