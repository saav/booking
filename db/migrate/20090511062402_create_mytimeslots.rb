class CreateMytimeslots < ActiveRecord::Migration
  def self.up
    create_table :mytimeslots do |t|
		t.string :time_slug, :unique=>true, :null=>false
		t.text :content, :default=>""		
		t.boolean :avilable, :default=>1
		t.integer :mydate_id, :null=>false
      	t.timestamps :created_at, :null=>false
		t.timestamps :updated_at, :null=>false
    end
  end

  def self.down
    drop_table :mytimeslots
  end
end
