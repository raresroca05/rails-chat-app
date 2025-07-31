class MessagesController < ApplicationController
  before_action :require_authentication
  before_action :set_chat_room
  
  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user
    
    if @message.save
      # Broadcast to all users in this chat room using Turbo Streams
      turbo_stream.broadcast_append_to(
        "chat_room_#{@chat_room.id}_messages",
        target: "messages",
        partial: "messages/message",
        locals: { message: @message, current_user: current_user }
      )
      
      respond_to do |format|
        format.html { redirect_to @chat_room }
        format.turbo_stream { head :no_content }
      end
    else
      @messages = @chat_room.messages.includes(:user).order(:created_at).last(50)
      render "chat_rooms/show", status: :unprocessable_entity
    end
  end
  
  private
  
  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end
  
  def message_params
    params.require(:message).permit(:content)
  end
end
