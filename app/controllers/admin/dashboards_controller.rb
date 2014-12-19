class Admin::DashboardsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?

  def is_admin?
    if current_user.admin?
      true
    else
      redirect_to root_url
    end
  end
end
