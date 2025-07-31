class User < ApplicationRecord
  has_secure_password
  
  has_many :messages, dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :chat_rooms, through: :room_memberships
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :display_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  
  normalizes :email, with: ->(email) { email.strip.downcase }
  
  private
  
  def password_required?
    new_record? || password.present?
  end
end
