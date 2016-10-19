class User < ApplicationRecord
  has_secure_password
  #attr_accessor :password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_insensitive: false }

  def received_messages
    Message.where(recipient: self)
  end

  def sent_messages
    Message.where(sender: self)
  end

  def latest_received_messages(n)
    received_messages.order(created_at: :desc).limit(n)
  end

  def unread_messages
    received_messages.unread
  end
end
