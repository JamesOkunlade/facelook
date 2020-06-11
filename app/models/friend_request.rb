# frozen_string_literal: true

# A FriendRequest Model
class FriendRequest < ApplicationRecord
  scope :pending, -> { where(status: 0) }

  validates :status, presence: true, inclusion: { in: [-1, 0, 1] }
  validate :sender_and_receiver_should_be_different
  validate :sender_and_receiver_should_not_be_friends

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  private

  def sender_and_receiver_should_be_different
    errors.add(:sender_receiver, 'sender and receiver pair should be different') if sender == receiver
  end

  def sender_and_receiver_should_not_be_friends
    errors.add(:sender_receiver, 'sender and receiver users are already friend') if sender.friends.include?(receiver)
  end
end
