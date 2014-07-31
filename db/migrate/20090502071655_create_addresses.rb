class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      	t.string :street, :null=>false
		t.string :suburb, :null=>false
		t.timestamps :created_at
		t.timestamps :updated_at
    end
  end

  def self.down
    drop_table :addresses
  end
end
