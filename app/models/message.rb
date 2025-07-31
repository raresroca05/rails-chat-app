class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :content, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc).limit(50) }
  scope :for_room, ->(room) { where(chat_room: room) }

  after_create_commit do
    chat_room.users.each do |user|
      broadcast_append_later_to(
        "chat_room_#{chat_room_id}_messages_for_user_#{user.id}",
        target: "messages",
        partial: "messages/message",
        locals: { message: self, current_user: user }
      )
    end
  end
end
