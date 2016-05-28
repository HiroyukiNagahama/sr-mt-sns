# Preview all emails at http://localhost:3000/rails/mailers/event_notify
class EventNotifyPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_notify/notify_new_event
  def notify_new_event
    EventNotify.notify_new_event
  end

end
