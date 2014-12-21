class Admin::PropertiesController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    saved = @property.save

    if saved
      @property.update_description(property_params[:description])
      redirect_to admin_property_path(@property)
    else
      flash[:alert] = @property.errors.full_messages
      render 'new'
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  private
  def property_params
    params.require(:property).permit(:street_address, :city, :state, :zip, :description)
  end
end
