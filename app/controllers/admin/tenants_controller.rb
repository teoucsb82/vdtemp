class Admin::TenantsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!, :is_admin?
  before_filter :load_users, :load_properties

  def show
    @tenant = User.find(params[:id])
  end
end
