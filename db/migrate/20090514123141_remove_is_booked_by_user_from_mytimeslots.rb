class RemoveIsBookedByUserFromMytimeslots < ActiveRecord::Migration
  def self.up
    remove_column :mytimeslots, :is_booked_by_user
  end

  def self.down
    add_column :mytimeslots, :is_booked_by_user, :boolean
  end
end
