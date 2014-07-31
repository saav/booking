module MycalendarHelper
	def timeslot_belongs_to_booker?(booker_id, timeslot_id)
		if timeslot_id == nil
			return false
		end

		@timeslot = Mytimeslot.find(timeslot_id)

		if booker_id == @timeslot.booker_id
			return true
		else
			return false
		end
	end

end
