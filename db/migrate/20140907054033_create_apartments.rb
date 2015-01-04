class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
			t.string :unit, :null => false
      t.integer :bedrooms, :null => false
      t.float :bathrooms, :null => false
      t.text :description, :null => false, :default => ""
      t.text :metadata
      t.boolean :available, :default => false

      t.timestamps
    end
  end
end
