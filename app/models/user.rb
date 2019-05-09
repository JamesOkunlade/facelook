class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { maximum: 20 },
  format: { with: /[a-z]+/i }
  validates :last_name, presence: true, length: { maximum: 20 },
  format: { with: /[a-z]+/i }

  has_many :posts, dependent: :destroy

end
