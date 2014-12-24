class Admin::ApartmentsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties
  before_filter :load_apartment, :only => [:edit, :show, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  def index
    @apartments = Apartment.all
  end

  def edit
    @apartment = Apartment.find(params[:id])
    @property = @apartment.property
  end

  def new
    @property = Property.find(params[:property_id])
    @apartment = Apartment.new
  end

  def create
    @property = Property.find(params[:property_id])
    @apartment = @property.apartments.new(apartment_params)
    @apartment.set_metadata_attributes(params[:metadata])
    saved = @apartment.save

    if saved
      redirect_to admin_apartment_path(@apartment)
    else
      flash[:alert] = @apartment.errors.full_messages
      render 'new'
    end
  end

  def show
  end

  def update
    @apartment.update_attributes!(apartment_params)
    render 'show'
  end

  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to admin_property_path(@property) }
    end
  end

  private
  def apartment_params
    params.require(:apartment).permit(:description, :bedrooms, :bathrooms, :unit, :metadata, :available)
  end

  def load_apartment
    @apartment = Apartment.find(params[:id])
    @property = @apartment.property
  end
end
