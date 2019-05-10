class Friendship < ApplicationRecord
  validates :adder, presence: true
  validates :added, presence: true

  belongs_to :adder, class_name: "User"
  belongs_to :added, class_name: "User"
end
