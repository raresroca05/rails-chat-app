require 'rails_helper'

RSpec.describe RoomMembership, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat_room) }
  end

  describe 'validations' do
    subject { build(:room_membership) }
    
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:chat_room_id) }
  end

  describe 'uniqueness constraint' do
    let(:user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    it 'prevents duplicate memberships' do
      create(:room_membership, user: user, chat_room: chat_room)
      duplicate = build(:room_membership, user: user, chat_room: chat_room)
      
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include('has already been taken')
    end
  end
end