# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def get_tr_css(index)
		if index % 2 == 0
			css_class = "tr_light"				
		else
			css_class = "tr_dark"
		end

		return css_class
	end
end
