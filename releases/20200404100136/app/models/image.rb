class Image < ApplicationRecord
  belongs_to :item
  mount_uploaders :url, ImageUploader
end
