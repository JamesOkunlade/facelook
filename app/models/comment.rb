# frozen_string_literal: true

# A Comment Model
class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 150 }
  belongs_to :post
  belongs_to :user

  self.per_page = 5
end
