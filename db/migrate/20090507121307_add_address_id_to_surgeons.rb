class AddAddressIdToSurgeons < ActiveRecord::Migration
  def self.up
    add_column :surgeons, :address_id, :integer
  end

  def self.down
    remove_column :surgeons, :address_id
  end
end
