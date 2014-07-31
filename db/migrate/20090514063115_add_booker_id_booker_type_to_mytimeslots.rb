class AddBookerIdBookerTypeToMytimeslots < ActiveRecord::Migration
  def self.up
    add_column :mytimeslots, :booker_id, :integer
    add_column :mytimeslots, :booker_type, :string
	remove_column :mytimeslots, :book_mytimeslot_id
  end

  def self.down
    remove_column :mytimeslots, :booker_type
    remove_column :mytimeslots, :booker_id
	add_column :book_mytimeslot_id, :integer
  end
end
