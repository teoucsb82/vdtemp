class Property < ActiveRecord::Base
  has_many :apartments, :dependent => :destroy
  has_many :images, :as => :imageable, :dependent => :destroy

  attr_accessor :description

  def description
    return metadata.blank? ? nil : JSON.parse(metadata)["description"]
  end

  def update_description(description)
    self.update_attribute(:metadata, { :description => description }.to_json) unless description.blank?
  end
end
