class PagesController < ApplicationController

  def index
    @properties = Property.all
    @apartments = Apartment.all
  end
end
