class Like < ApplicationRecord
  validates :user, presence: true
  validates :post, presence: true

  belongs_to :user
  belongs_to :post
end
