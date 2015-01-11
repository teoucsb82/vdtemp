class Apartment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  scope :available, -> { where(available: true) }

	has_one :lease
  has_many :images, :as => :imageable, :dependent => :destroy
  has_many :tenants, :foreign_key => 'apartment_id', :class_name => "User"
  belongs_to :property

	after_initialize :load_metadata_attributes
	attr_accessor :rent, :square_footage, :parking,
								:stove, :washer, :dryer, :dishwasher, :refrigerator,
								:microwave, :laundry_on_site, :hardwood_floors, :pets_allowed,
								:gas_heater, :balcony, :air_conditioning, :fireplace, :patio,
                :address

  def self.search(params)
    radius = params[:radius].blank? ? 20 : params[:radius].to_i
    if params["location"].blank?
      properties = Property.joins(:apartments).where(:apartments => {:available => true})
    else
      properties = Property.near(params["location"], radius).joins(:apartments).where(:apartments => {:available => true})
    end
    apartments = []
    properties.each do |property|
      property.apartments.each do |apt|
        apartments << apt if apt.available?
      end
    end
    apartments.reject! { |apt| apt.square_footage < params["square_footage"].to_i } unless params["square_footage"].blank?
    apartments.reject! { |apt| apt.bedrooms != params["bedrooms"].to_i } unless params["bedrooms"].blank? || params["bedrooms"].downcase == "any"
    apartments.reject! { |apt| apt.bathrooms != params["bathrooms"].to_i } unless params["bathrooms"].blank? || params["bathrooms"].downcase == "any"
    apartments.reject! { |apt| apt.min_price < params["min_price"].to_i } unless params["min_price"].blank? || params["min_price"].downcase == "any"
    apartments.reject! { |apt| apt.max_price > params["max_price"].to_i } unless params["max_price"].blank? || params["max_price"].downcase == "any"

    json_array = []
    apartments.each do |apt|
      h = JSON.parse(apt.to_json)
      h["image"] = (apt.images.empty? ? "" : apt.images.first.photo.small.url)
      h["address"] = apt.address
      json_array << h.to_json
    end
    return json_array.uniq
  end

  def amenities
    results = []
    metadata_to_ignore = ["rent", "square_footage", "parking"]

    meta = self.metadata ? JSON.parse(self.metadata) : []
    meta.each do |k, v|
      results << k if v && !metadata_to_ignore.include?(k.downcase)
    end
    return results
  end

  def load_metadata_attributes
    self.address          = "#{self.property.street_address}, ##{unit}"
    return if self.metadata.blank?
    apartment_data        = JSON.parse(self.metadata)
    self.rent             = apartment_data["rent"]
    self.square_footage   = apartment_data["square_footage"]
    self.parking          = apartment_data["parking"]
    self.stove            = apartment_data["stove"]
    self.washer           = apartment_data["washer"]
    self.dryer            = apartment_data["dryer"]
    self.dishwasher       = apartment_data["dishwasher"]
    self.refrigerator     = apartment_data["refrigerator"]
    self.microwave        = apartment_data["microwave"]
    self.laundry_on_site  = apartment_data["laundry_on_site"]
    self.hardwood_floors  = apartment_data["hardwood_floors"]
    self.pets_allowed     = apartment_data["pets_allowed"]
    self.gas_heater       = apartment_data["gas_heater"]
    self.balcony          = apartment_data["balcony"]
    self.air_conditioning = apartment_data["air_conditioning"]
    self.fireplace        = apartment_data["fireplace"]
    self.patio            = apartment_data["patio"]
  end

	def set_metadata_attributes(params)
		return if params.nil?
		self.update_attribute(:metadata, {  :rent => params["rent"].tr('^0-9.', '').to_f,
																				:square_footage => params["square_footage"].tr('^0-9.', '').to_i,
																				:parking => params["parking"],
																				:stove => params["stove"],
																				:washer => params["washer"],
																				:dryer => params["dryer"],
																				:dishwasher => params["dishwasher"],
																				:refrigerator => params["refrigerator"],
																				:microwave => params["microwave"],
																				:laundry_on_site => params["laundry_on_site"],
																				:hardwood_floors => params["hardwood_floors"],
																				:pets_allowed => params["pets_allowed"],
																				:gas_heater => params["gas_heater"],
																				:balcony => params["balcony"],
																				:air_conditioning => params["air_conditioning"],
																				:fireplace => params["fireplace"],
																				:patio => params["patio"] }.to_json)
	end
end