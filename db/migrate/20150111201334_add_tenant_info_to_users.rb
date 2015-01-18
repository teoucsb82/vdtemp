class AddTenantInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name_first, :string
    add_column :users, :name_last, :string
    add_column :users, :phone, :string
    add_column :users, :lease_id, :integer
  end
end
