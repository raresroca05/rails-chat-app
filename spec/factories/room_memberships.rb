FactoryBot.define do
  factory :room_membership do
    association :user
    association :chat_room
  end
end