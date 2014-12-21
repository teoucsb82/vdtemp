class Admin::DashboardsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties

  def index
    @users = User.where("id != ?", current_user.id)
  end
end
