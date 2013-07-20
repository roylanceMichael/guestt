class BlogownerController < ApplicationController
	def index
		redirect_to blogowner_approved_path
	end

	def newblog
	end

	def approvedblogs
	end

	def pendingblogs
	end

	def rejectedblogs
	end
end