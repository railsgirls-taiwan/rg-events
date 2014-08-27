class Admin::EventsController < AdminController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]

  def index
    @admin_events = Admin::Event.all
  end

  def show
  end

  def new
    @admin_event = Admin::Event.new
  end

  def edit
  end

  def create
    @admin_event = Admin::Event.new(admin_event_params)
    respond_to do |format|
      if @admin_event.save
        format.html { redirect_to @admin_event, notice: '活動建立成功！' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_event.update(admin_event_params)
        format.html { redirect_to @admin_event, notice: '活動更新成功！' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @admin_event.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: '活動刪除成功！' }
    end
  end

  private

  def set_admin_event
      @admin_event = Admin::Event.find_by_id(params[:id])
  end

  def admin_event_params
    params.require(:admin_event)
          .permit(:title, :date, :place, :description,
                  fields_attributes: %i[id name type required multiple option_items _destroy])
  end
end
