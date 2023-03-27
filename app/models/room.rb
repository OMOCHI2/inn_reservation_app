class Room < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true, length: {maximum: 100}
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :address, presence: true

  has_one_attached :avatar
  belongs_to :user
  has_many :reservations, :dependent => :destroy
end
