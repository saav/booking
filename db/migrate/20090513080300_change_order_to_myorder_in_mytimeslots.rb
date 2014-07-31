class ChangeOrderToMyorderInMytimeslots < ActiveRecord::Migration
  def self.up
		#rename_column :mytimeslots, :order, :myorder
  end

  def self.down
  end
end
