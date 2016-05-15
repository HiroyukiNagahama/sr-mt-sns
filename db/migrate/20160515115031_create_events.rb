class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_place,null: false,comments: "開催場所"
      t.datetime :event_date,null: false,comments: "開催日時"
      t.text :memo,comments: "備考"
      t.boolean :notify_flag,default: false,null: false,comments: "通知フラグ"
      t.timestamps null: false
    end
  end
end
