class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  def index
    @admin_users = Admin::User.all
  end

  def show
  end

  def new
    @admin_user = Admin::User.new
  end

  def edit
  end

  def create
    @admin_user = Admin::User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: t('crud.created_successfully!', name: Admin::User.model_name.human) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: t('crud.updated_successfully!', name: Admin::User.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
    end
  end

  private
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    def admin_user_params
      params.require(:admin_user).permit(:name, :email, :tel, :password)
    end
end
