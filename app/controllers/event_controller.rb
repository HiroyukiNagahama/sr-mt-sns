class EventController < ApplicationController
  before_action :authenticate_user!
  before_action :is_manager, only: [:create,:notify_events]



  def index
    find_records
  end

  def show
    set_record
    @event_joins = {ok: [1,11,111],ng: [2,22],pending: [3,33],no: [4,444]}
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
    #User.where().find_each do |user|
    User.where(email: ENV['OWNER_AD2']).find_each do |user|
      EventNotify.notify_new_event(evs, user.email).deliver
    end
    redirect_to action: :index
  end


  private
  def find_records
    @records = Event.
        find_date(params[:event] && params[:event][:e_date]).
        find_place(params[:event_place]).
        find_notify(params[:is_notify]).
        sort_desc.page(params[:page])
    # @records = Event.all
  end

  def set_record
    @record = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
        :id, :e_date, :start_time, :end_time, :event_place,:memo)
  end

end
