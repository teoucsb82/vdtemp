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

    if @apartment.save
      flash[:notice] = "Apartment successfully created"
      return redirect_to admin_apartment_path(@apartment)
    else
      flash[:alert] = @apartment.errors.full_messages.join(".")
      return redirect_to new_admin_property_apartment_path(@property, @apartment)
    end
  end

  def show
    # @images = @apartment.images
    # respond_to do |format|
    #   format.js { render :json => @images.collect { |p| p.to_jq_upload }.to_json }
    #   format.html
    # end
  end

  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        @apartment.set_metadata_attributes(params[:metadata])

        format.html { redirect_to admin_apartment_path(@apartment), notice: 'Apartment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', :error => @apartment.errors }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_photos
    @apartment = Apartment.find(params[:apartment_id])

    p_attr = params[:image]
    p_attr[:photo] = params[:image][:photo].first if params[:image][:photo].class == Array

    @image = @apartment.images.new(image_params)

    respond_to do |format|
      if @image.save
        format.html {
          render :json => [@image.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@image.to_jq_upload]}, status: :created }
      else
        format.html { render action: "show" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def photos
    @apartment = Apartment.find(params[:apartment_id])
    @images = @apartment.images
    render :json => @images.collect { |i| i.to_jq_upload }.to_json
  end

  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to admin_property_path(@property) }
    end
  end

  def destroy_photo
    @image = Image.find(params[:id])
    @image.destroy
    render :json => true
  end

  private
  def apartment_params
    params.require(:apartment).permit(:description, :bedrooms, :bathrooms, :unit, :metadata, :available)
  end

  def image_params
    params.require(:image).permit(:photo)
  end

  def load_apartment
    @apartment = Apartment.find(params[:id])
    @property = @apartment.property
  end
end
