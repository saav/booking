class CreateSurgeons < ActiveRecord::Migration
  def self.up
    create_table :surgeons do |t|
		t.string :first_name, :null=>false
		t.string :last_name, :null=>false		
		t.string :description, :null=>false
		t.string :email, :null=>false
		t.string :password, :null=>false
		t.string :landline, :null=>false, :unique=>true
		t.string :mobile
		t.boolean :enabled, :default=>1
		t.timestamps :created_at, :null=>false
    	t.timestamps :updated_at, :null=>false
    end

			Surgeon.create :first_name=>"Phil", :last_name=>"McGraw", :description=>"Dr.Phil", :email=>"phil@phil.com", :password=>"11111111", :landline=>"12345"
	Surgeon.create :first_name=>"Anniter", :last_name=>"Payton", :description=>"Dr. Anniter", :email=>"anniter@anniter.com", :password=>"11111111", :landline=>"89893456"
  end

  def self.down
    drop_table :surgeons
  end
end
