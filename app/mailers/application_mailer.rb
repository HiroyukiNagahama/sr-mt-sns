class ApplicationMailer < ActionMailer::Base
  default from: "event_info@cryptic-gorge-56075.herokuapp.com"
  layout 'mailer'

  def set_mailer_option
    if Rails.env.production?
      ActionMailer::Base.delivery_method = :smtp
      ActionMailer::Base.smtp_settings = HEROKU_SMTP_SETTINGS
    else
      ActionMailer::Base.delivery_method = :sendmail
    end
  end
end
