require 'test_helper'

class EventNotifyTest < ActionMailer::TestCase
  test "notify_new_event" do
    mail = EventNotify.notify_new_event
    assert_equal "Notify new event", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
