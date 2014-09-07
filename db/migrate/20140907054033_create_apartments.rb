class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
			t.text :location
      t.text :metadata

      t.timestamps
    end
  end
end
