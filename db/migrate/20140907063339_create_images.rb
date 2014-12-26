class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string  :title
      t.text    :description
      t.boolean :active, :default => false
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
