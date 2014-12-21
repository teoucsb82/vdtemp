class AddPropertyIdToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :property_id, :integer
  end
end
