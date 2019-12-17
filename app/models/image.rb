class Image < ApplicationRecord
  belongs_to :item, inverse_of: :images
  mount_uploaders :image, ImageUploader
end
