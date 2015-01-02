class BackgroundChecksController < ApplicationController
  def new
    @properties = Property.available
    @background_check = BackgroundCheck.new
  end

  def create
    @background_check = BackgroundCheck.new(background_check_params)

    if @background_check.save
      flash[:notice] = "Application successfully submitted"
      return redirect_to admin_apartment_path(@apartment)
    else
      flash[:alert] = @background_check.errors.full_messages.join(".")
      return redirect_to new_admin_property_apartment_path(@property, @apartment)
    end
  end

  private
  def background_check_params
    params.require(:background_check).permit(:name, :email, :apartment_id, :acknowledgment)
  end
end
