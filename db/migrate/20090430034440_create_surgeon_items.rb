class CreateSurgeonItems < ActiveRecord::Migration
  def self.up
    create_table :surgeon_items do |t|
		t.string :name, :null=>false
		t.string :description, :null=>false
		t.float :cost, :default=>0		
		t.integer :surgeon_id, :null=>false
		t.boolean :enabled, :default=>1
      	t.timestamps :created_at, :null=>false
		t.timestamps :updated_at, :null=>false
    end

	# doctor 1
	SurgeonItem.create :name=>"examination", :description=>"examination", :cost=>10.00, :surgeon_id=>1
	SurgeonItem.create :name=>"operation", :description=>"operation", :cost=>100.00, :surgeon_id=>1

	# doctor 2
	SurgeonItem.create :name=>"examination", :description=>"examination", :cost=>10.00, :surgeon_id=>2
	SurgeonItem.create :name=>"operation", :description=>"operation", :cost=>100.00, :surgeon_id=>2
  end

  def self.down
    drop_table :surgeon_items
  end
end
