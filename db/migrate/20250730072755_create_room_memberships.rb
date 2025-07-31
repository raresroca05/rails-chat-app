class CreateRoomMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :room_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_room, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :room_memberships, [:user_id, :chat_room_id], unique: true
  end
end
