class Surgeon < ActiveRecord::Base
	has_many :mydates
	has_many :surgeonItems
	belongs_to :address
	has_many :mytimeslots, :as=>:booker, :order=>"myorder ASC"

	validates_presence_of :first_name, :last_name, :email, :password
	validates_confirmation_of :password
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_uniqueness_of :email
end
