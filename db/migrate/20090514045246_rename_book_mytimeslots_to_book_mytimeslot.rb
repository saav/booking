class RenameBookMytimeslotsToBookMytimeslot < ActiveRecord::Migration
  def self.up
	rename_table :book_mytimeslots, :book_mytimeslot
  end

  def self.down
	rename_table :book_mytimeslot, :book_mytimeslots
  end
end
