class Event < ActiveRecord::Base

  #表示日時
  def ev_date
    (event_date + Rational(9, 24)).strftime('%Y-%m-%d %H:%M:%S')
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
      Event.create({event_place: name, event_date: time + 10, memo: "テスト#{i}", notify_flag: i.even? ? false : true})
    end
  end
end
