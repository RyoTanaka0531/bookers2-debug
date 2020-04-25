class AddColumnToChat < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :user_id, :integer
    add_column :chats, :room_id, :integer
  end
end
