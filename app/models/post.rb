class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 1000 }
  validates :user, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
