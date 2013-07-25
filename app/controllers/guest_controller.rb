class GuestController < ApplicationController
	def index
	end

	def updateblogstatustosold
		user_email = current_user.email
		blog_id = params[:blog_id]
		
		blog = Blog.find(blog_id)
		
		if user_email == nil || blog == nil
			raise "invalid parameters"
		end

		createstatus(blog_id, BlogStatus.sold, user_email)

		render :json => { :success => "true" }
	end

	def soldblogs
		@blog_statuses = BlogStatus
		.joins(@@latestBlogStatusJoin)
		.where("status = :sold and guest_email = :guest_email", {:sold => "#{BlogStatus.sold}", :guest_email => current_user.email })
	end
end