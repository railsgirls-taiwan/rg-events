class EventsController < ApplicationController
  def index
    @events = Event.order('id DESC').page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end
end
