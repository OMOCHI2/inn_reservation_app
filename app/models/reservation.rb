class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :num_of_people, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validate :end_date_check

  belongs_to :user
  belongs_to :room

  def end_date_check
    return if (start_date.nil? || end_date.nil?)
    errors.add(:end_date, "は開始日より前の日付は選択出来ません") if start_date > end_date
  end
end
