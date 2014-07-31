class ChangeAvilableToAvailable < ActiveRecord::Migration
  def self.up
	rename_column("mydates", "avilable", "available")
 	rename_column("mytimeslots", "avilable", "available")
  end

  def self.down
  	
  end
end
