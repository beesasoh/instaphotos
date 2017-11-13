class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: '640x' }

  validates_attachment :image, presence: true,
                               content_type: { content_type: %r{\Aimage/.*\Z} },
                               size: { in: 0..2.megabytes }
end
