class User < ApplicationRecord
  store :preferences, accessors: [:display_type]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
                    styles: { thumb: '100x100#', medium: '400x400#' },
                    default_url: '/images/profile-holder.png'

  validates_attachment :avatar,
                       content_type: { content_type: %r{\Aimage/.*\Z} },
                       size: { in: 0..2.megabytes }

  has_many :posts, dependent: :destroy
end
