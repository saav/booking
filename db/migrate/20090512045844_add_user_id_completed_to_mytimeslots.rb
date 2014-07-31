class AddUserIdCompletedToMytimeslots < ActiveRecord::Migration
  def self.up
    add_column :mytimeslots, :user_id, :integer, :null=>false
    add_column :mytimeslots, :completed, :boolean, :default=>false
  end

  def self.down
    remove_column :mytimeslots, :completed
    remove_column :mytimeslots, :user_id
  end
end
