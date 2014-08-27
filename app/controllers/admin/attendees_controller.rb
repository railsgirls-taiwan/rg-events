class Admin::AttendeesController < AdminController
  before_action :set_admin_event
  before_action :set_admin_attendee, only: [:show, :edit, :update, :destroy]

  def index
    @admin_attendees = @admin_event.attendees.all
  end

  def show
  end

  def new
    @admin_attendee = @admin_event.attendees.new
  end

  def edit
  end

  def create
    @admin_attendee = @admin_event.attendees.new(admin_attendee_params)
    respond_to do |format|
      if @admin_attendee.save
        format.html { redirect_to admin_event_attendee_path(@admin_event, @admin_attendee), notice: t('crud.created_successfully!', name: Admin::Attendee.model_name.human) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_attendee.update(admin_attendee_params)
        format.html { redirect_to admin_form_attendee_path(@admin_event, @admin_attendee), notice: t('crud.updated_successfully!', name: Admin::Attendee.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @admin_attendee.destroy
    respond_to do |format|
      format.html { redirect_to [@admin_form, Attendee] }
    end
  end

  private
    def set_admin_attendee
      @admin_attendee = Admin::Attendee.find(params[:id])
    end

    def set_admin_event
      @admin_event = Admin::Event.find(params[:event_id])
    end

    def admin_attendee_params
      params
        .require(:admin_attendee)
        .permit(
          :user_id, :form_id, field_values_attributes: [:id, :_destroy, :attendee_id, :field_id, :value, value: []]
        )
    end
end
