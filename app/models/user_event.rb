class UserEvent < ActiveRecord::Base
  belongs_to :events
  belongs_to :users

  paginates_per 3

  GO="出陣"
  PEND="燻り"
  STOP="撤退"
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
