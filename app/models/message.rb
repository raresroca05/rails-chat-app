class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  
  validates :content, presence: true, length: { maximum: 1000 }
  
  scope :recent, -> { order(created_at: :desc).limit(50) }
  scope :for_room, ->(room) { where(chat_room: room) }
end
