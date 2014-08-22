class SurgeonsController < ApplicationController
	def display_surgeons
		@surgeons = Surgeon.find(:all)
	end
	
	def index
		__check_authentication		

		surgeon_id = session[:surgeon_surgeonID]
		if surgeon_id
			@surgeon = Surgeon.find(surgeon_id)					
			@address = @surgeon.address
			@state = @address.state
	
			@mydates = @surgeon.mydates
		else

		end
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
			redirect_to :controller=>"surgeons", :action=>"index"
		elsif session[:surgeon_surgeonID] != nil
			# view
			surgeon_id = session[:surgeon_surgeonID]
			@surgeon = Surgeon.find(surgeon_id)


			if @surgeon
				
			else
				flash[:notice] = "Cannot find this surgeon to edit!"
				redirect_to :controller=>"users", :action=>"login" and return
			end
		else
			
		end
	end	



	def cancel_booking
		__check_authentication		

		booking_id = params[:id]
		if booking_id
			SurgeonsUsers.destroy(booking_id)
			flash[:notice] = "You have canceled one booking!"			
			redirect_to :action=>"index" and return
		else
			redirect_to :action=>"index" and return
		end
	end

	
	def display_user
		__check_authentication

		user_id = params[:user_id]
		if user_id
			@user = User.find(user_id)

			if @user
				@address = @user.address
				@state = @address.state
			else
				redirect_to :action=>"index" and return
			end
		else
			redirect_to :action=>"index" and return
		end
	end


private
	def __check_authentication
		if session[:surgeon_surgeonID].blank?
			flash[:notice] = "Please login."
			redirect_to :controller=>:users, :action=>:login and return
		else
			return true
		end
	end

	
	def __save_user
		first_name = params[:surgeon][:first_name]
		last_name = params[:surgeon][:last_name]
		email = params[:surgeon][:email]
		password = params[:password]
		conf_password = params[:confirmation_password]			
		street = params[:address][:street] 
		suburb = params[:address][:suburb]
		state_id = params[:state][:state_id]
		postcode = params[:address][:postcode]		
		landline = params[:surgeon][:landline]
		mobile = params[:surgeon][:mobile]
		description = params[:surgeon][:description]

		if password == conf_password && !password.empty? && !conf_password.empty?

		else
			@errors = {"Password"=>["Passwords don't match!"]}
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
			return
		end

		# new
		@surgeon = Surgeon.new
		@surgeon.first_name = first_name
		@surgeon.last_name = last_name
		@surgeon.email = email		
		@surgeon.password = password		
		@surgeon.landline = landline
		@surgeon.mobile = mobile
		@surgeon.description = description
		@surgeon.address_id = @address.id
		if @surgeon.save

		else
			return
		end

		# Remember the sesssion
		session[:surgeon_surgeonID] = @surgeon.id

		redirect_to :action=>"index" and return
	end


	def __save_edited_user
		surgeon_id = params[:surgeon][:surgeon_id]
		address_id = params[:surgeon][:address][:address_id]			
		@surgeon = Surgeon.find(surgeon_id)
		@address = Address.find(address_id)	

		if @surgeon && @address
			first_name = params[:surgeon][:first_name]
			last_name = params[:surgeon][:last_name]
			email = params[:surgeon][:email]
			password = params[:password]
			conf_password = params[:confirmation_password]		
			street = params[:surgeon][:address][:street] 
			suburb = params[:surgeon][:address][:suburb]
			state_id = params[:state][:state_id]
			postcode = params[:surgeon][:address][:postcode]		
			landline = params[:surgeon][:landline]
			mobile = params[:surgeon][:mobile]	
			description = params[:surgeon][:description]

			if password == conf_password && !password.empty? && !conf_password.empty?

			else
				@errors = {"password"=>["passwords don't match!"]} # one way to create an attribute
				return
			end

			@surgeon.first_name = first_name
			@surgeon.last_name = last_name
			#@user.email = email #can't change
			@surgeon.password = password
			@surgeon.landline = landline					
			@surgeon.mobile = mobile
			@surgeon.description = description

			if @surgeon.save

			else
				@errors = @surgeon.errors
				return
			end			

			@address.street = street			
			@address.suburb = suburb
			@address.postcode = postcode
			@address.state_id = state_id

			if @address.save

			else
				@errors = @address.errors
				return
			end

			flash[:notice] = "Update surgeon's detail!"
		else

		end	
	end


end
