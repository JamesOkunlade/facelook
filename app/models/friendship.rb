class Friendship < ApplicationRecord

  belongs_to :adder, class_name: "User"
  belongs_to :added, class_name: "User"
end
