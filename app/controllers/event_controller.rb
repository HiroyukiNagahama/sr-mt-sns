class EventController < ApplicationController

  def index
    find_records
  end

  def show
    set_record
    @event_joins = {ok: [1,11,111],ng: [2,22],pending: [3,33],no: [4,444]}
  end


  private
  def find_records
    @records = Event.all
  end

  def set_record
    @record = Event.find(params[:id])
  end
end
