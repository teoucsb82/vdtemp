class Admin::PropertiesController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties
  before_filter :load_property, :only => [:edit, :destroy, :update, :show]
  skip_before_filter :verify_authenticity_token

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

  def destroy
    @property.destroy
    redirect_to admin_path
  end

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        @property.update_description(property_params[:description])
        format.html { redirect_to admin_property_path(@property), notice: 'Property was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def property_params
    params.require(:property).permit(:street_address, :city, :state, :zip, :description)
  end

  def load_property
    @property = Property.find(params[:id])
  end
end
