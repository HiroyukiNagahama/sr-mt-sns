class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.integer :event_id,comments: "イベントID"
      t.integer :user_id,comments: "userID"
      t.string :memo,comments: "備考"
      t.integer :attendance_type,comments: "出席"
      t.timestamps null: false
    end
  end
end
