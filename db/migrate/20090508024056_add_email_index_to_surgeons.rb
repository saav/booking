class AddEmailIndexToSurgeons < ActiveRecord::Migration
  def self.up
    add_index :surgeons, :email, {:unique=>true, :name=>"surgeons_email_index"}
  end

  def self.down
    remove_index :surgeons, :surgeons_email_index
  end
end
