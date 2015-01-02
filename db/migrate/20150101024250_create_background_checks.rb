class CreateBackgroundChecks < ActiveRecord::Migration
  def change
    create_table :background_checks do |t|
      t.integer :apartment_id, :null => false
      t.string :name, :null => false
      t.string :email, :null => false
      t.text :personal_info
      t.text :address_info
      t.text :employer_info
      t.text :vehickle_info
      t.boolean :acknowledgment, :default => false
  
      t.timestamps
    end

    add_index :background_checks, :email, :unique => true
  end
end
