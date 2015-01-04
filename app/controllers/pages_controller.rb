class PagesController < ApplicationController

  def index
    @properties = Property.all
    @apartments = Apartment.joins(:images).uniq

    respond_to do |format|
      if params[:v]
        return render 'index2'
      else
        format.html
      end
    end
  end
end
