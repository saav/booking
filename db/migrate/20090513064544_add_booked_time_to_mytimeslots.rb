class AddBookedTimeToMytimeslots < ActiveRecord::Migration
  def self.up
    add_column :mytimeslots, :booked_time, :string, :null=>false
  end

  def self.down
    remove_column :mytimeslots, :booked_time
  end
end
