class Mydate < ActiveRecord::Base
	has_many :mytimeslots
	belongs_to :surgeon
end
