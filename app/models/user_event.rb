class UserEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  paginates_per 3

  GO="出席"
  PEND="保留"
  STOP="欠席"
  STATUS_GO = 1
  STATUS_PEND = 2
  STATUS_STOP = 3

  BTN={
      STATUS_GO => "btn-primary",
      STATUS_PEND => "btn-warning",
      STATUS_STOP => "btn-danger"
  }

  STATUS={
      STATUS_GO => GO,
      STATUS_PEND => PEND,
      STATUS_STOP => STOP
  }
end
