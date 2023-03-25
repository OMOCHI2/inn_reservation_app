class User < ApplicationRecord
  has_one_attached :avatar
  has_many :rooms, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
