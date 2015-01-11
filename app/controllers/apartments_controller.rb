class ApartmentsController < ApplicationController
  before_filter :load_apartment, :only => [:show, :edit, :update, :destroy]

  def search
    results = Apartment.search(params)
    render :json => results
  end

  private
  def load_apartment
    @apartment = Apartment.find(params[:id])
  end
end
