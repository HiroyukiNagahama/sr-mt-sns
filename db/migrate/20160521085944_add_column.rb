class AddColumn < ActiveRecord::Migration
  def change
    add_column(:events,:e_date,:date,null: false,comments: "開催日")
    add_column(:events,:start_time,:integer,null: false,comments: "開始時間")
    add_column(:events,:end_time,:integer,null: false,comments: "終了時間")
    remove_column(:events,:event_date,:datetime)
  end
end
