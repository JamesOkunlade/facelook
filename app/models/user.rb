# frozen_string_literal: true

# A User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true, length: { maximum: 20 }, format: { with: /[a-z]+/i, message: 'valid name' }
  validates :last_name, presence: true, length: { maximum: 20 }, format: { with: /[a-z]+/i, message: 'Valid name' }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests_sent, foreign_key: :sender_id, class_name: 'FriendRequest', dependent: :destroy
  has_many :friend_requests_received, foreign_key: :receiver_id, class_name: 'FriendRequest', dependent: :destroy
  has_many :friendships, foreign_key: :adder_id, dependent: :destroy
  has_many :friendships_2, class_name: 'Friendship', foreign_key: :added_id, dependent: :destroy
  has_many :friends, through: :friendships, source: :added

  # mount_uploader :profile_photo, PhotoUploader
  # mount_uploader :cover_photo, PhotoUploader

  def friendable_users
    User.all.where.not('id IN (?)', [id] + friends.ids +
    friend_requests_sent.pending.pluck(:receiver_id) + friend_requests_received.pending.pluck(:sender_id))
  end

  def establish_friendship(other_user)
    friends.push(other_user)
    other_user.friends.push(self)
  rescue
    errors.add(:friends, "You're already friends")
    other_user.errors.add(:friends, "You're already friends")
  end

  def destroy_friendship(other_user)
    friends.delete(other_user)
    other_user.friends.delete(self)
  end

  def feed
    friends_ids = friends.ids.join(',')
    if friends_ids.blank?
      Post.where('user_id = :user_id', user_id: id)
    else
      Post.where("user_id IN (#{friends_ids}) OR user_id = :user_id", user_id: id)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name = auth.info.name.split(' ')[-1]
    end
  end

  # after_create :welcome_send
  #
  # def welcome_send
  #   UserMailer.with(user: self).welcome_email.deliver_now
  # end
end
