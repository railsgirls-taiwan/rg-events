class AttendeesController < ApplicationController
  before_action :set_event, only: %i[new create]

  def index
    @attendees = current_user.attendees
  end

  def show
    @attendee = current_user.attendees.find(params[:id])
  end

  def new
    @attendee = Attendee.new
  end

  def create
    @attendee = @event.attendees.new(attendee_params)
    @attendee.user = current_user
    if @attendee.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def attendee_params
    params.require(:attendee).permit(
      field_values_attributes: [:id, :_destroy, :attendee_id, :field_id, :value, value: []]
    )
  end
end
