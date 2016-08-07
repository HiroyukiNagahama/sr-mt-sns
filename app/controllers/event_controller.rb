class EventController < ApplicationController
  before_action :authenticate_user!
  before_action :is_manager, only: [:create,:notify_events]

  def index
    find_records
  end

  def show
    event_joins = {ok: [],ng: [],pending: []}
    users = []
    set_record
    UserEvent.where(event_id: @record.id).find_each do |ue|
      case ue.attendance_type
        when UserEvent::STATUS_GO
          event_joins[:ok] << ue.user.name
        when UserEvent::STATUS_STOP
          event_joins[:ng] << ue.user.name
        when UserEvent::STATUS_PEND
          event_joins[:pending] << ue.user.name
      end
      users << ue.user_id
    end
    event_joins[:no] = User.where.not(id: users).pluck(:name)
    @event_joins = event_joins
  end

  def create
    if request.post?
      e = Event.new(event_params)
      if e.save
        redirect_to '/event/index'
      else
        flash[:notice] = e.errors.full_messages
        @event = e
      end
    end
  end

  def notify_events
    evs = params[:id] ? [set_record] : Event.future_events(false)
    if Rails.env.development?
      User.where(email: 'sr.m.tigers@gmail.com').find_each do |user|
        EventNotify.notify_new_event(evs, user.email).deliver_now
      end
    else
      User.where(active_flag: true).find_each do |user|
        EventNotify.notify_new_event(evs, user.email).deliver_now
      end
    end
    evs.each{|e|e.update(notify_flag: true)} #２度目の送信も許可
    redirect_to action: :index
  end

  def destroy_record
    e = set_record
    if e.destroy
      flash[:alert] = "削除しました"
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to action: :index
  end

  def update_memo
    set_record
    @record.update(memo: params[:event][:memo])
    redirect_to action: :show,id: params[:id]
  end


  private
  def find_records
    @records = Event.
        find_date(params[:event] && params[:event][:e_date]).
        find_place(params[:event_place]).
        find_notify(params[:is_notify]).
        sort_desc.page(params[:page])
  end

  def set_record
    @record = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
        :id, :e_date, :start_time, :end_time, :event_place,:memo)
  end

end
