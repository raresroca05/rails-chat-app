FactoryBot.define do
  factory :chat_room do
    sequence(:name) { |n| "Chat Room #{n}" }
  end
end