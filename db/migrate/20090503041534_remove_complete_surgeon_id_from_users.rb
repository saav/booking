class RemoveCompleteSurgeonIdFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :complete
    remove_column :users, :surgeon_id
  end

  def self.down
    add_column :users, :surgeon_id, :integer
    add_column :users, :complete, :boolean
  end
end
