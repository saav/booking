class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
		t.string :name, :null=>false
      	t.timestamps :created_at
		t.timestamps :updated_at
    end

	State.create :name=>"Victoria"
	State.create :name=>"Queensland"
	State.create :name=>"NSW"
	State.create :name=>"ACT"
	State.create :name=>"Tasmania"
	State.create :name=>"South Australia"
	State.create :name=>"Western Australia"
	State.create :name=>"Northen Territory"
  end

  def self.down
    drop_table :states
  end
end
