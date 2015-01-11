class Property < ActiveRecord::Base
  scope :available, -> { joins(:apartments).where(:apartments => { available: true } ) }
  has_many :apartments, :dependent => :destroy
  has_many :images, :as => :imageable, :dependent => :destroy

  attr_accessor :description, :address
  geocoded_by :address
  after_save :geocode

  # def self.available
  #   self.joins(:apartments).where(:apartments => { available: true } ).all
  # end

  def description
    return metadata.blank? ? nil : JSON.parse(metadata)["description"]
  end

  def address
    [street_address, city, state, zip].compact.join(', ')
  end

  def update_description(description)
    self.update_attribute(:metadata, { :description => description }.to_json) unless description.blank?
  end
end
