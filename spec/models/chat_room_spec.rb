require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:messages).dependent(:destroy) }
    it { is_expected.to have_many(:room_memberships).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:room_memberships) }
  end

  describe 'instance methods' do
    let(:chat_room) { create(:chat_room) }
    let(:user) { create(:user) }

    describe '#has_member?' do
      context 'when user is a member' do
        before { chat_room.add_member(user) }

        it 'returns true' do
          expect(chat_room.has_member?(user)).to be true
        end
      end

      context 'when user is not a member' do
        it 'returns false' do
          expect(chat_room.has_member?(user)).to be false
        end
      end
    end

    describe '#add_member' do
      it 'adds user to chat room' do
        expect { chat_room.add_member(user) }
          .to change { chat_room.users.count }.by(1)
      end

      it 'does not add duplicate members' do
        chat_room.add_member(user)
        expect { chat_room.add_member(user) }
          .not_to change { chat_room.users.count }
      end
    end

    describe '#remove_member' do
      before { chat_room.add_member(user) }

      it 'removes user from chat room' do
        expect { chat_room.remove_member(user) }
          .to change { chat_room.users.count }.by(-1)
      end
    end
  end
end