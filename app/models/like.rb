# frozen_string_literal: true

# A Like Model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
