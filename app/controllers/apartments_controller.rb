class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.set_location_attributes(params[:location])
    @apartment.set_metadata_attributes(params[:metadata])
    saved = @apartment.save

    if saved
      redirect_to @apartment
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
    params.require(:apartment).permit(:description, :location, :metadata)
  end
end
