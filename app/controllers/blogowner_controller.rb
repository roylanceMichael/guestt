class BlogownerController < ApplicationController
	def index
		
	end

	def newblog
	end

	def createblog
		newBlog = Blog.new
		newBlog.name = params[:name]
		newBlog.description = params[:description]
		newBlog.url = params[:url]
		newBlog.user_email = current_user.email
		newBlog.save

		createstatus(newBlog.id, BlogStatus.pending, nil)

		redirect_to blogowner_pending_path
	end
end