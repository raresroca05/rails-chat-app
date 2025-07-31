class ChatRoomsController < ApplicationController
  before_action :require_authentication
  before_action :set_chat_room, only: [ :show, :join, :leave ]

  def index
    @chat_rooms = ChatRoom.all
    @user_rooms = current_user.chat_rooms
  end

  def show
    @messages = @chat_room.messages.includes(:user).order(:created_at).last(50)
    @message = Message.new
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      @chat_room.add_member(current_user)
      redirect_to @chat_room, notice: "#{@chat_room.name} was created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def join
    @chat_room.add_member(current_user)
    redirect_to @chat_room, notice: "You joined #{@chat_room.name}!"
  end

  def leave
    @chat_room.remove_member(current_user)
    redirect_to chat_rooms_path, notice: "You left #{@chat_room.name}"
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
