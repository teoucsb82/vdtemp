# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => "teo@teo.com", :password => "foobar", :admin => true)
properties = {
  "1814 10th Street"   => { :units => (1..5).to_a.map(&:to_s), :city => "Santa Monica", :state => "CA", :zip => "90404" },
  "1818 10th Street"   => { :units => ["Cottage", "A", "B", "C", "D"], :city => "Santa Monica", :state => "CA", :zip => "90404" },
  "2467 Oak Street"    => { :units => ["Garage", "A", "B", "C"], :city => "Santa Monica", :state => "CA", :zip => "90404" },
  "1241 Amherst Ave"   => { :units => (1..9).to_a.map(&:to_s), :city => "Los Angeles", :state => "CA", :zip => "90025" },
  "1723 Centinela Ave" => { :units => (1..5).to_a.map(&:to_s), :city => "Santa Monica", :state => "CA", :zip => "90404" }
}

properties.sort.each do |street_address, data|
  property = Property.create(:street_address => street_address, :city => data[:city], :state => data[:state], :zip => data[:zip])
  data[:units].each do |unit|
    property.apartments.create(:unit => unit, :bedrooms => 0, :bathrooms => 0)
  end
end