class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :users, through: :room_memberships

  validates :name, presence: true, uniqueness: true

  def has_member?(user)
    users.include?(user)
  end

  def add_member(user)
    room_memberships.find_or_create_by(user: user)
  end

  def remove_member(user)
    room_memberships.find_by(user: user)&.destroy
  end
end
