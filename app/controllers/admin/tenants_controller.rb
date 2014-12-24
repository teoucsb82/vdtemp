class Admin::TenantsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties
  before_filter :load_tenant, :only => [:edit, :show, :update, :destroy]

  def index
  end

  def edit
  end

  def new
    @tenant = User.new
    @apartment = Apartment.find(params[:apartment_id])
    @property = @apartment.property
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def tenant_params
    params.require(:tenant).permit()
  end

  def load_tenant
    @tenant = User.find(params[:id])
    @apartment = @tenant.apartment
    @property = @apartment.property
  end
end
