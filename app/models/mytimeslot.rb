class Mytimeslot < ActiveRecord::Base
	belongs_to :mydate
	belongs_to :booker, :polymorphic=>true
end
