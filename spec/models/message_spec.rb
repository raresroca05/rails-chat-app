require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(1000) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat_room) }
  end

  describe 'scopes' do
    let(:chat_room) { create(:chat_room) }
    let!(:old_messages) { create_list(:message, 3, chat_room: chat_room, created_at: 1.hour.ago) }
    let!(:recent_messages) { create_list(:message, 2, chat_room: chat_room, created_at: 1.minute.ago) }

    describe '.recent' do
      it 'returns messages in descending order' do
        messages = Message.recent
        expect(messages.first.created_at).to be > messages.last.created_at
      end

      it 'limits to 50 messages' do
        create_list(:message, 60, chat_room: chat_room)
        expect(Message.recent.count).to eq(50)
      end
    end

    describe '.for_room' do
      let(:other_room) { create(:chat_room) }
      let!(:other_messages) { create_list(:message, 2, chat_room: other_room) }

      it 'returns messages for specified room only' do
        room_messages = Message.for_room(chat_room)
        expect(room_messages.count).to eq(5)
        expect(room_messages.all? { |m| m.chat_room == chat_room }).to be true
      end
    end
  end
end