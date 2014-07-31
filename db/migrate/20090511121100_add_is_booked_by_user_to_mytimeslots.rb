class AddIsBookedByUserToMytimeslots < ActiveRecord::Migration
  def self.up
    add_column :mytimeslots, :is_booked_by_user, :boolean, :default=>false
  end

  def self.down
    remove_column :mytimeslots, :is_booked_by_user
  end
end
