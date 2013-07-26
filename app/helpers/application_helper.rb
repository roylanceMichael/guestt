module ApplicationHelper
	def formatDate(d)
		Date.parse(d.to_s).to_s(:db)
	end

	def homeclass
		if(request.env['PATH_INFO'] == "/")
			"active"
		else
			""
		end
	end

	def guestclass
		if(request.env['PATH_INFO'] == "/guest")
			"active"
		else
			""
		end
	end

	def blogownerclass
		if(request.env['PATH_INFO'] == "/blogowner")
			"active"
		else
			""
		end
	end

	def adminclass
		if(request.env['PATH_INFO'] == "/admin")
			"active"
		else
			""
		end
	end
end
