class Room < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum: 100 }
  validates :price, presence: true
  validates :address, presence: true

  has_one_attached :avatar
  belongs_to :user
end
