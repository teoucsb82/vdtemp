class Apartment < ActiveRecord::Base
	has_one :lease
  has_many :images, :as => :imageable
  has_many :tenants, :foreign_key => 'apartment_id', :class_name => "User"

	after_initialize :load_location_attributes
	attr_accessor :street_address, :unit, :city, :state, :zip

	after_initialize :load_metadata_attributes
	attr_accessor :rent,
								:bedrooms, :bathrooms, :square_footage, :parking,
								:stove, :washer, :dryer, :microwave, :dishwasher, :refrigerator,
								:microwave, :laundry_on_site, :hardwood_floors, :pets_allowed,
								:gas_heater, :balcony, :air_conditioning, :fireplace, :patio

	def load_location_attributes
		return if self.location.blank?
		location = JSON.parse(self.location)
		self.street_address = location["street_address"]
		self.unit 					= location["unit"]
		self.city 					= location["city"]
		self.state 					= location["state"]
		self.zip            = location["zip"]
	end

	def load_metadata_attributes
		return if self.metadata.blank?
		apartment_data        = JSON.parse(self.metadata)
		self.rent             = apartment_data["rent"]
		self.bedrooms         = apartment_data["bedrooms"]
		self.bathrooms        = apartment_data["bathrooms"]
		self.square_footage   = apartment_data["square_footage"]
		self.parking          = apartment_data["parking"]
		self.stove            = apartment_data["stove"]
		self.washer           = apartment_data["washer"]
		self.dryer            = apartment_data["dryer"]
		self.microwave        = apartment_data["microwave"]
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

end
