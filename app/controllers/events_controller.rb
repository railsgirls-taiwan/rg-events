class EventsController < ApplicationController
  def index
    @events = Event.order('id DESC')
  end

  def show
    @event = Event.find(params[:id])
  end
end
