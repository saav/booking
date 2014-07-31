class AddEmailIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :email, {:unique=>true, :name=>"users_email_index"}
  end

  def self.down
    remove_index :users, :users_email_index
  end
end
