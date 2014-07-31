class UsersController < ApplicationController
	def index
		__check_authentication

		user_id = session[:user_userID]		
		if user_id
			@user = User.find(user_id)
			@address = @user.address
			@state = @address.state

			@timeslots = @user.mytimeslots
		else

		end
	end	


	def login
		if params[:login]
			if params[:user_type] == "surgeon"							
				__authenticate_surgeon
			else
				__authenticate_user
			end		
		else
			# view
		end		
	end


	def logout
		session[:user_userID] = nil
		session[:user_surgeonID] = nil

		session[:surgeon_surgeonID] = nil

		session[:universe_fullname] = nil

		redirect_to :action=>"login"
	end


	def register
		if params[:register]
			__save_user
		elsif params[:cancel]
			redirect_to :controller=>"users", :action=>"index" and return
		else
			# display its view
		end
	end


	def edit
		__check_authentication

		if params[:save]
			__save_edited_user
		elsif params[:cancel]
			redirect_to :controller=>"users", :action=>"index" and return
		elsif session[:user_userID] != nil
			# view
			user_id = session[:user_userID]
			@user = User.find(user_id)

			if @user
				
			else
				flash[:notice] = "Cannot find this user to edit!"
				redirect_to :controller=>"users", :action=>"login"
			end
		else
			
		end
	end


	def cancel_booking
		__check_authentication		

		timeslot_id = params[:timeslot_id]
		if timeslot_id
			Mytimeslot.destroy(timeslot_id)
			flash[:notice] = "You have canceled one booking!"			
			redirect_to :action=>"index"
		else
			redirect_to :action=>"index"
		end
	end	
	

	def book
		__remember_surgeon_id
		condi = __check_authentication
		
		if condi == true
			id = params[:id]

			if id
				# Display this surgeon's info in detail, including surgeon items
				surgeon_id = id
				if Surgeon.exists?(surgeon_id)
					# redirect to this surgeon's calendar
					redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
				else
					flash[:notice] = "No such surgeon!"
				end
			elsif session[:user_surgeonID] # coming from booking, then login
				surgeon_id = session[:user_surgeonID]
				if Surgeon.exists?(surgeon_id)
					redirect_to :controller=>"mycalendar", :action=>"display_for_user", :surgeon_id=>surgeon_id
				else
					flash[:notice] = "No such surgeon!"
				end
			else
				flash[:notice] = "No surgeon id when booking"
			end		
		else
					
		end
	end


	def display_surgeon
		__check_authentication

		surgeon_id = params[:surgeon_id]		

		if surgeon_id
			@surgeon = Surgeon.find(surgeon_id)
			
			if @surgeon
				@address = @surgeon.address
				@state = @address.state
				@items = @surgeon.surgeonItems
			else
				redirect_to :action=>"index" and return
			end
		else
			redirect_to :action=>"index" and return
		end
	end


private
	def __check_authentication
		if session[:user_userID].blank?
			flash[:notice] = "Please login."
			redirect_to :controller=>:users, :action=>:login and return
		else
			return true
		end
	end


	def __authenticate_user
		email = params[:user][:email]		
		password = params[:user][:password]

		if !email.empty? && !password.empty?
			user = User.find(:first, :conditions=>{:email=>email, :password=>password})

			if User.exists?(:email=>email, :password=>password)
				session[:user_userID] = user.id
				session[:universe_fullname] = user.first_name + " " + user.last_name
				flash[:notice] = "You (#{session[:universe_fullname]}) are now login!"

				if session[:user_surgeonID]
					redirect_to :controller=>"users", :action=>"book" and return
				else
					redirect_to :controller=>"users", :action=>"index" and return	
				end			
			else
				flash[:notice] = "There are something wrong with your email or password!"
				redirect_to :action=>"login" and return
			end
		else
			flash[:notice] = "Email or password is empty!"
			redirect_to :action=>"login" and return
		end
	end


	def __save_user
		first_name = params[:user][:first_name]
		last_name = params[:user][:last_name]
		email = params[:user][:email]
		password = params[:user][:password]
		conf_password = params[:user][:password_confirmation] 
		street = params[:address][:street] 
		suburb = params[:address][:suburb]
		state_id = params[:state][:state_id]
		postcode = params[:address][:postcode]		
		landline = params[:user][:landline]
		mobile = params[:user][:mobile]

		# check confirmation password
		if password == conf_password && !password.empty? && !conf_password.empty?

		else
			@errors = {"password"=>["passwords don't match!"]} # one way to create an attribute
			return
		end

		# check state
		if state_id.empty?
			@errors = {"state"=>["You must select a state"]}
			return
		else

		end

		@address = Address.new
		@address.street = street
		@address.suburb = suburb		
		@address.state_id = state_id
		@address.postcode = postcode
		if @address.save
		
		else
			#debugger

			@errors = @address.errors
			return
		end

		# new
		@user = User.new
		@user.first_name = first_name
		@user.last_name = last_name
		@user.email = email		
		@user.password = password		
		@user.landline = landline
		@user.mobile = mobile
		@user.address_id = @address.id
		if @user.save

		else
			@errors = @user.errors
			return
		end

		# Remember the sesssion
		session[:user_userID] = @user.id

		redirect_to :action=>"index" and return
	end


	def __save_edited_user
		user_id = params[:user][:user_id]
		address_id = params[:user][:address][:address_id]			
		@user = User.find(user_id)
		@address = Address.find(address_id)	

		if @user && @address
			first_name = params[:user][:first_name]
			last_name = params[:user][:last_name]
			email = params[:user][:email]
			password = params[:password]
			conf_password = params[:confirmation_password]			
			street = params[:user][:address][:street] 
			suburb = params[:user][:address][:suburb]
			state_id = params[:state][:state_id]
			postcode = params[:user][:address][:postcode]		
			landline = params[:user][:landline]
			mobile = params[:user][:mobile]	

			if password == conf_password && !password.empty? && !conf_password.empty?

			else
				@errors = {"password"=>["Passwords don't match!"]}
				return
			end

			@user.first_name = first_name
			@user.last_name = last_name
			#@user.email = email #can't change
			@user.password = password
			@user.landline = landline					
			@user.mobile = mobile

			if @user.save

			else
				@errors = @user.errors
				return
			end			

			@address.street = street			
			@address.suburb = suburb
			@address.postcode = postcode
			@address.state_id = state_id

			if @address.save

			else
				@errors = @user.errors
				return
			end

			flash[:notice] = "Update user's detail!"
			return
		else

		end
	end

	
	def __save_booking
		surgeon_id = params[:surgeon][:surgeon_id]
		user_id = session[:user_userID]	
		description = params[:booking][:description]
		
		@surgeonsUsers = SurgeonsUsers.new
		@surgeonsUsers.surgeon_id = surgeon_id
		@surgeonsUsers.user_id = user_id
		@surgeonsUsers.description = description

		if @surgeonsUsers.save

		else

		end
	end


	def __remember_surgeon_id
		id = params[:id] # expect coming from /surgeons/book/:id
		if id 
			session[:user_surgeonID] = id
		else

		end
	end


	def __authenticate_surgeon
		email = params[:user][:email]		
		password = params[:user][:password]

		if !email.empty? && !password.empty?
			surgeon = Surgeon.find(:first, :conditions=>{:email=>email, :password=>password})

			if Surgeon.exists?(:email=>email, :password=>password)
				session[:surgeon_surgeonID] = surgeon.id
				session[:universe_fullname] = surgeon.first_name + " " + surgeon.last_name				
				flash[:notice] = "You (#{session[:universe_fullname]}) are now login!"				
				redirect_to :controller=>"surgeons", :action=>"index" and return				
			else
				flash[:notice] = "There are something wrong with your email or password!"
				redirect_to :controller=>"users", :action=>"login" and return
			end
		else
			flash[:notice] = "Email or password is empty!"
			redirect_to :controller=>"users", :action=>"login" and return
		end
	end

end
