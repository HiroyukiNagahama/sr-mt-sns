class Event < ActiveRecord::Base
  has_many :user_events,dependent: :delete_all

  validates_presence_of :e_date,:start_time,:end_time,:event_place

  scope :find_date, -> e_date {where(e_date: e_date) if e_date.present?}
  scope :find_place, -> place {where(arel_table[:event_place].matches("%#{place}%")) if place.present?}
  scope :find_notify, -> is_notify {where(notify_flag: is_notify) if [true,false,"true","false"].include?(is_notify)}
  scope :sort_desc, -> {order('e_date desc')}
  scope :future_events,  -> notify {where("e_date >= ? and notify_flag = ?",Date.today,notify)}

  paginates_per 20

  #表示日時
  def ev_date
    e_date.to_s + ("  %02d:00 時 〜 %02d:00 時" % [start_time,end_time])
  end

  #表示名称

  #通知表示
  def is_notify?
    notify_flag ? '通知済' : '未通知'
  end

  def self.create_sample
    time = DateTime.now
    60.times do |i|
      name = (i%3 == 0 ? '東村山' : '府中の森')
      Event.create({event_place: name, e_date: Date.today,start_time: time,end_time: time + 10, memo: "テスト#{i}", notify_flag: i.even? ? false : true})
    end
  end
end
