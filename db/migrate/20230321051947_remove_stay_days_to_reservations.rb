class RemoveStayDaysToReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :stay_days, :integer
  end
end
