class MessagesController < ApplicationController

  def index
    received
  end

  def create
    @user = User.find params[:user_id]
    @message = User.sent_messages.build message_params
    if @message.save
    else
    end
  end

  def show
    @message = Message.find params[:id]
    if @message.unread? && current_user == @message.recipient
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
    params.require(:message).require(:recipient_id, :body)
  end
end
