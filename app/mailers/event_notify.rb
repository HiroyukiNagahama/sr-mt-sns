class EventNotify < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notify.notify_new_event.subject
  #
  def notify_new_event(evs,to)
    @evs = evs
    mail to: to,subject: "お知らせ[musashino-taigers]"#, x_msmail_priority: 'High'
  end

  #テスト用メソッド
  def self.do_test(heroku=false)
    if heroku
      EventNotify.send_test_heroku.deliver
    else
      EventNotify.send_test.deliver
    end
  end

  def send_test
    set_mailer_option
    mail(to: [OWNER_AD1_DEV,OWNER_AD2_DEV], subject: 'テストメール')
  end

  def send_test_heroku
    set_mailer_option
    mail(to: [ENV['OWNER_AD1'],ENV['OWNER_AD2']], subject: 'herokuテストメール')
  end

end
