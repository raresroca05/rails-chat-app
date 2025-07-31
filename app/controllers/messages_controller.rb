class MessagesController < ApplicationController
  before_action :require_authentication
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.html { redirect_to @chat_room }
        format.turbo_stream { head :ok }
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
