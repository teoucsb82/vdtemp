class Image < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :imageable, polymorphic: true
  mount_uploader :photo, PhotoUploader

  def to_jq_upload
    host = Rails.env.production? ? "https://secure-hollows-5983.herokuapp.com" : "localhost:3000"
    {
      "name" => read_attribute(:photo),
      "size" => photo.size,
      "url" => photo.url,
      "thumbnail_url" => photo.thumbnail.url,
      "delete_url" => admin_apartment_apartment_destroy_photo_url(:apartment_id => self.imageable_id, :id => id, :host => host ),
      "delete_type" => "DELETE"
    }
  end
end
