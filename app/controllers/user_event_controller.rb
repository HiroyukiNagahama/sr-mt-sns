class UserEventController < ApplicationController
  before_action :authenticate_user! ,except: [:submit_attendance]

  def index
    find_events
  end

  def submit_attendance
    find_user_event
    @event.attendance_type = params[:status_id].to_i
    @event.save
    data = {
        status: "OK",attendance_type: params[:status_id].to_i,
        attendance_text: UserEvent::STATUS[params[:status_id].to_i],btn_msg: UserEvent::BTN[params[:status_id].to_i]}
    render text: data.to_json
  end

  private
  def find_events
    @events = Event.future_events(true).order("e_date DESC").page(params[:page])
  end

  def find_record
    @user_event = UserEvent.find_by(id: params[:id])
  end

  def find_event
    @event = Event.find_by(event_id: params[:event_id])
  end

  def find_user_event
    @event = UserEvent.find_or_initialize_by(user_id: params[:user_id],event_id: params[:event_id])
  end
end
