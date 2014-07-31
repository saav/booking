class AddPostcodeToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :postcode, :string
  end

  def self.down
    remove_column :addresses, :postcode
  end
end
