class CreateMydates < ActiveRecord::Migration
  def self.up
    create_table :mydates do |t|
		t.string :date_slug, :unique=>true, :null=>false
      	t.integer :surgeon_id, :null=>false
		t.boolean :avilable, :default=>1
		t.timestamps :created_at, :null=>false
		t.timestamps :updated_at, :null=>false
    end
  end

  def self.down
    drop_table :mydates
  end
end
