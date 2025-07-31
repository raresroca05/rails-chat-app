class HomeController < ApplicationController
  def index
    @user_count = User.count
    @room_count = ChatRoom.count
    @message_count = Message.count
  end
end
