class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :status
      t.references :sender, references: :users
      t.references :receiver, references: :users

      t.timestamps
    end
    add_index :friend_requests, [:sender_id, :receiver_id], unique: true
  end
end
