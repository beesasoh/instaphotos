class Comment < ApplicationRecord
  validates :text,    presence: true
  validates :user_id, presence: true

  belongs_to :commentable
  belongs_to :user
end
