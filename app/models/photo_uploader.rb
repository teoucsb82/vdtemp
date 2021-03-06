class PhotoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  # process :convert => 'png'
  # process :tags => ['post_photo']

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :carousel do
    process :resize_to_fill => [540, 365, :north]
  end

  version :main do
    process :resize_to_fill => [750]
  end

  version :small do
    resize_to_fit(200, 200)
  end

  version :thumbnail do
    resize_to_fit(100, 100)
  end
end