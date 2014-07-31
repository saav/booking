class SurgeonItemController < ApplicationController
	
	def index
		__check_authentication				
		
		if params[:id]		
			surgeon_id = params[:id]	
		else
			surgeon_id = session[:surgeon_surgeonID]
		end

		@surgeon = Surgeon.find(surgeon_id)
		@surgeonItems = @surgeon.surgeonItems

		if @surgeon && @surgeonItems
			
		else
			flash[:notice] = "Something wrong to display surgeon items!"
			redirect_to :controller=>"surgeons", :action=>"index"
		end

	end

	
	def add
		__check_authentication

		if params[:add]
			__add_item
			flash[:notice] = "You have added one item!"
			redirect_to :controller=>"surgeon_item", :action=>"index"
		elsif params[:cancel]
			flash[:notice] = "You cancel the add item action!"
			redirect_to :controller=>"surgeon_item", :action=>"index"
		else
			@item = SurgeonItem.new
		end
	end	


	def edit 
		__check_authentication	

		if params[:save]
			__save_item
			redirect_to :controller=>"surgeons", :action=>"index"
		elsif params[:cancel]
			redirect_to :controller=>"surgeons", :action=>"index"
		else
			item_id = params[:id]
			@item = SurgeonItem.find(item_id)
		
			if @item
			
			else
				flash[:notice] = "Item doesn't exist!"
				redirect_to :action=>"index"
			end
		end
	end

	
	def delete
		__check_authentication

		item_id = params[:id]
		if item_id
			SurgeonItem.destroy(item_id)
			flash[:notice] = "You have destroyed one item!"
			redirect_to :action=>"index"
		elsif params[:cancel]
			flash[:notice] = "You cancel the delete item action!"
			redirect_to :controller=>"surgeon_item", :action=>"index"
		else
			redirect_to :controller=>"surgeon_item", :action=>"index"
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


	def __save_item
		item_id = params[:item][:item_id]	
		name = params[:item][:name]
		description = params[:item][:description]
		cost = params[:item][:cost]

		@item = SurgeonItem.find(item_id)
		@item.name = name
		@item.description = description		
		@item.cost = cost.to_f

		if @item.save

		else

		end

	end


	def __add_item
		surgeon_id = session[:surgeon_surgeonID]	
		name = params[:item][:name]
		description = params[:item][:description]
		cost = params[:item][:cost] 

		@item = SurgeonItem.new
		@item.name = name
		@item.description = description
		@item.cost = cost
		@item.surgeon_id = surgeon_id

		if @item.save

		else

		end
	end

end
