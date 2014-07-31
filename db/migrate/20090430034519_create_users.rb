class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		t.string :first_name, :null=>false
		t.string :last_name, :null=>false
		t.string :password, :null=>false		
		t.string :email, :null=>false
		t.string :landline
		t.string :mobile, :null=>false
		t.boolean :enabled, :default=>1
		t.boolean :complete, :defalt=>0
		t.integer :surgeon_id, :null=>false
    	t.timestamps :created_at
		t.timestamps :updated_at
    end
  end

  def self.down
    drop_table :users
  end
end
