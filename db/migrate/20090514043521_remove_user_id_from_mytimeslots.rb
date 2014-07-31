class RemoveUserIdFromMytimeslots < ActiveRecord::Migration
  def self.up
    remove_column :mytimeslots, :user_id
  end

  def self.down
    add_column :mytimeslots, :user_id, :integer
  end
end
