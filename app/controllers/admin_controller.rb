class AdminController < ApplicationController
  before_action :check_role
  helper_method :is_admin?

  def index
  end

  private

  def check_role
    redirect_to root_path, alert: '你沒有管理者權限，對不起' unless current_user.is_admin?
  end
end
