class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :adder, references: :users
      t.references :added, references: :users

      t.timestamps
    end

    add_index :friendships, [:adder_id, :added_id], unique: true
    end
end
