class Address < ActiveRecord::Base
	belongs_to :state
	has_one :user
	has_one :surgeon

	validates_presence_of :street, :suburb
end
