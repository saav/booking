class MycalendarController < ApplicationController
	attr_accessor :hours
	attr_accessor :start_hour
	attr_accessor :end_hour
		
	
	def initialize
		@hours = 8
		@start_hour = 9
		@end_hour = 17
	end		


	def display_for_surgeon
		__check_surgeon_authentication

		surgeon_id = session[:surgeon_surgeonID]
		if surgeon_id
			if !Surgeon.exists?(surgeon_id)			
				redirect_to :controller=>"surgeons", :action=>"display_surgeons"
			else				
				@surgeon = Surgeon.find(surgeon_id)
			end
		else
			redirect_to :controller=>"surgeons", :action=>"display_surgeons"
		end		

		
		@year = params[:year]
		@month = params[:month]
		@day = params[:day]				

		if @year != nil && @month != nil && @day != nil		
			date_slug = @year + "_" + @month + "_" + @day
			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})

			if @mydate
				# get time slots
				existing_timeslots = @mydate.mytimeslots
				@timeslots = __generate_rest_timeslots(existing_timeslots)
			else
				@mydate = Mydate.new
				@timeslots = __generate_default_timeslots
			end
		else
			# Default to today
			@year = Time.now.year
			@month = Time.now.month
			@day = Time.now.day
			date_slug = @year.to_s + "_" + @month.to_s + "_" + @day.to_s

			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})
			if @mydate
				# get time slots
				existing_timeslots = @mydate.mytimeslots
				@timeslots = __generate_rest_timeslots(existing_timeslots)
			else
				@mydate = Mydate.new
				@timeslots = __generate_default_timeslots
			end
		end
	end


	def display_for_user
		__check_user_authentication

		# get user_id
		@user_id = session[:user_userID]

		# expect surgeon_id
		surgeon_id = params[:surgeon_id]
		if surgeon_id
			if !Surgeon.exists?(surgeon_id)			
				redirect_to :controller=>"surgeons", :action=>"display_surgeons"
			else
				@surgeon = Surgeon.find(surgeon_id)
			end
		else
			redirect_to :controller=>"surgeons", :action=>"display_surgeons"
		end


		@year = params[:year]
		@month = params[:month]
		@day = params[:day]


		if @year != nil && @month != nil && @day != nil
			date_slug = @year + "_" + @month + "_" + @day
			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})

			if @mydate
				# get time slots
				existing_timeslots = @mydate.mytimeslots
				@timeslots = __generate_rest_timeslots(existing_timeslots)
			else
				@mydate = Mydate.new
				@timeslots = __generate_default_timeslots
			end
		else
			# Default to today
			@year = Time.now.year
			@month = Time.now.month
			@day = Time.now.day
			date_slug = @year.to_s + "_" + @month.to_s + "_" + @day.to_s

			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})
			if @mydate
				# get time slots
				existing_timeslots = @mydate.mytimeslots
				@timeslots = __generate_rest_timeslots(existing_timeslots)
			else
				@mydate = Mydate.new
				@timeslots = __generate_default_timeslots
			end
		end
	end

	
	def save_timeslots
		__check_user_authentication

		user_id = session[:user_userID]

		if params[:submit]
			surgeon_id = params[:date][:surgeon_id]			
			year = params[:date][:year]
			month = params[:date][:month]
			day = params[:date][:day]
			
			date_slug = year + "_" + month + "_" + day
			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})
			
			if @mydate
				__save_fresh_timeslots(@mydate.id, user_id)
				redirect_to :action=>"display_for_user", :surgeon_id=>surgeon_id
			else
				# create mydate object
				@mydate = Mydate.new
				@mydate.date_slug = date_slug				
				@mydate.surgeon_id = surgeon_id				
				if @mydate.save
	
				else

				end

				# save timeslots directly
				__save_fresh_timeslots(@mydate.id, user_id)
				redirect_to :action=>"display_for_user", :surgeon_id=>surgeon_id
			end
		elsif params[:cancel]
			surgeon_id = params[:date][:surgeon_id]
			redirect_to :action=>"display_for_user", :surgeon_id=>surgeon_id
		else

		end
	end

	
	def save_surgeon_timeslots
		__check_surgeon_authentication

		surgeon_id = session[:surgeon_surgeonID]

		if params[:submit]
			
			debugger

			year = params[:date][:year]
			month = params[:date][:month]
			day = params[:date][:day]
	
			date_slug = year + "_" + month + "_" + day
			@mydate = Mydate.find(:first, :conditions=>{:date_slug=>date_slug, :surgeon_id=>surgeon_id})
			
			if @mydate
				__save_fresh_surgeon_timeslots(@mydate.id, surgeon_id)
				redirect_to :action=>"display_for_surgeon"
			else
				# create mydate object
				@mydate = Mydate.new
				@mydate.date_slug = date_slug				
				@mydate.surgeon_id = surgeon_id				
				if @mydate.save
	
				else

				end

				# save timeslots directly				
				__save_fresh_surgeon_timeslots(@mydate.id, surgeon_id)
				redirect_to :action=>"display_for_surgeon"
			end
		elsif params[:cancel]
			redirect_to :action=>"display_for_surgeon"
		else

		end
	end


	def user_edit
		__check_user_authentication

		timeslot_id = params[:timeslot_id]
		surgeon_id = params[:surgeon_id]

		if params[:submit]
			content = params[:timeslot][:content]
			timeslot = Mytimeslot.find(timeslot_id)
			timeslot.content = content
			if timeslot.save
				redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
			else

			end
		elsif params[:delete]		
			if timeslot_id
				Mytimeslot.destroy(timeslot_id)
			else

			end

			redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
		elsif params[:cancel]
			redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
			
		else
			#hidden fields
			@timeslot_id = timeslot_id			
			@surgeon_id = surgeon_id

			@timeslot = Mytimeslot.find(timeslot_id)
			if @timeslot
				#view
			else
				redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
			end
		end

		
	end


	def user_cancel
		__check_user_authentication

		timeslot_id = params[:timeslot_id]
		surgeon_id = params[:surgeon_id]		

		if timeslot_id 
			Mytimeslot.destroy(timeslot_id)
			flash[:notice] = "You have canceled a booking!"
			redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
		else
			flash[:notice] = "No such timeslot!"
			redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
		end
	end

	
	def surgeon_cancel
		__check_surgeon_authentication

		timeslot_id = params[:timeslot_id]
		surgeon_id = params[:surgeon_id]		

		if timeslot_id 
			Mytimeslot.destroy(timeslot_id)
			flash[:notice] = "You have canceled a booking!"
			redirect_to :controller=>"mycalendar", :action=>"display_for_surgeon", :surgeon_id=>surgeon_id
		else
			flash[:notice] = "No such timeslot!"
			redirect_to :controller=>"mycalendar", :action=>"display_for_surgeon", :surgeon_id=>surgeon_id
		end
	end
	

private
	def __generate_default_timeslots
		times = @hours - 1 # 9, 10, 11, 12, 13, 14, 15, 16, 17 => 8 hours 
		array = Array.new
		
		0.upto(times) do |i|
			timeslot = Mytimeslot.new
			timeslot.time_slug = i + @start_hour
			timeslot.available = true		
			array[i] = timeslot
		end

		return array
	end

	
	def __save_fresh_timeslots(mydate_id, booker_id)
		checkboxes = params[:timeslots]	
		contents = params[:contents]
		orders = params[:orders]

		checkboxes.each do |name, value|		
			if value == "1"
				content = contents[name]

				timeslot = Mytimeslot.new
				timeslot.time_slug = name
				timeslot.content = content
				timeslot.mydate_id = mydate_id
				timeslot.available = false
				timeslot.booker_id = booker_id
				timeslot.booker_type = "User"
				timeslot.myorder = orders[name]
				if timeslot.save

				else

				end
			else
				# do nothing
			end			
		end
	end


	def __save_fresh_surgeon_timeslots(mydate_id, booker_id)
		checkboxes = params[:timeslots]	
		contents = params[:contents]
		orders = params[:orders]

		checkboxes.each do |name, value|		
			if value == "1"
				content = contents[name]

				timeslot = Mytimeslot.new
				timeslot.time_slug = name
				timeslot.content = content
				timeslot.mydate_id = mydate_id
				timeslot.available = false
				timeslot.booker_id = booker_id
				timeslot.booker_type = "Surgeon"
				timeslot.myorder = orders[name]
				if timeslot.save

				else

				end
			else
				# do nothing
			end			
		end
	end	



	def __generate_rest_timeslots(existing_timeslots)
		if existing_timeslots.count > 0
			array = Array.new
			times = @hours - 1

			0.upto(times) do |i|
				default_time_slug = (i + @start_hour).to_s
				if existing_timeslot = __is_timeslot_existed(existing_timeslots, default_time_slug)
					array[i] = existing_timeslot
				else
					timeslot = Mytimeslot.new
					timeslot.time_slug = i + @start_hour
					timeslot.available = true
					array[i] = timeslot
				end
			end

			#debugger

			return array
		else
			return __generate_default_timeslots
		end
	end

		
	def __is_timeslot_existed(existing_timeslots, time_slug)
		existing_timeslots.each do |existing_timeslot|
			if existing_timeslot.time_slug == time_slug
				return existing_timeslot
			else
				# continue looping
			end
		end

		return false
	end


	def __check_user_authentication
		if session[:user_userID].blank?
			flash[:notice] = "Please login."
			redirect_to :controller=>:users, :action=>:login and return
		else
			return true
		end
	end

	
	def __check_surgeon_authentication
		if session[:surgeon_surgeonID].blank?
			flash[:notice] = "Please login."
			redirect_to :controller=>:users, :action=>:login and return
		else
			return true
		end
	end


end
