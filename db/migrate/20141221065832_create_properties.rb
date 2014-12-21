class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.text :street_address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false, :default => "CA"
      t.integer :zip, :null => false
      t.text :metadata

      t.timestamps
    end

    add_index :properties, :street_address, unique: true
  end
end
