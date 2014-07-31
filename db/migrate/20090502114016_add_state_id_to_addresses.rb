class AddStateIdToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :state_id, :integer
  end

  def self.down
    remove_column :addresses, :state_id
  end
end
