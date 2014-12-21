class Admin::ApartmentsController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!
  before_filter :is_admin?
  before_filter :load_users, :load_properties

  def index
    @apartments = Apartment.all
  end

  def new
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
    @apartment = Apartment.find(params[:id])
  end

  private
  def apartment_params
    params.require(:apartment).permit(:description, :bedrooms, :bathrooms, :unit, :metadata, :available)
  end
end
