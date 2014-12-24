class Apartment < ActiveRecord::Base
	has_one :lease
  has_many :images, :as => :imageable
  has_many :tenants, :foreign_key => 'apartment_id', :class_name => "User"
  belongs_to :property

	after_initialize :load_metadata_attributes
	attr_accessor :rent, :square_footage, :parking,
								:stove, :washer, :dryer, :dishwasher, :refrigerator,
								:microwave, :laundry_on_site, :hardwood_floors, :pets_allowed,
								:gas_heater, :balcony, :air_conditioning, :fireplace, :patio

	def load_metadata_attributes
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
		self.update_attribute(:metadata, {  :rent => params[:rent].tr('^0-9.', '').to_f,
																				:square_footage => params[:square_footage].tr('^0-9.', '').to_i,
																				:parking => params[:parking],
																				:stove => params[:stove],
																				:washer => params[:washer],
																				:dryer => params[:dryer],
																				:dishwasher => params[:dishwasher],
																				:refrigerator => params[:refrigerator],
																				:microwave => params[:microwave],
																				:laundry_on_site => params[:laundry_on_site],
																				:hardwood_floors => params[:hardwood_floors],
																				:pets_allowed => params[:pets_allowed],
																				:gas_heater => params[:gas_heater],
																				:balcony => params[:balcony],
																				:air_conditioning => params[:air_conditioning],
																				:fireplace => params[:fireplace],
																				:patio => params[:patio] }.to_json)
	end
end