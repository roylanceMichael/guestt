class AdminController < ApplicationController
	def blogs
		render :json => BlogStatus.joins(@@latestBlogStatusJoin).to_json(:include => [:blog])
	end

	def manageblogs
		#serves up the html page
	end

	def updateblogstatus
		blog_id = params[:blog_id]
		status = params[:status]

		if blog_id == nil || Blog.find(blog_id) == nil || !BlogStatus.acceptablestatus(status)
			raise "invalid parameters"
		end

		createstatus(blog_id, status, nil)

		render :json => { :success => "true" }
	end

	def approvedblogs
		@blog_statuses = BlogStatus.joins(@@latestBlogStatusJoin).where("blog_statuses.status = '#{BlogStatus.approved}'")
	end

	def pendingblogs
		@blog_statuses = BlogStatus.joins(@@latestBlogStatusJoin).where("blog_statuses.status = '#{BlogStatus.pending}'")
	end

	def rejectedblogs
		@blog_statuses = BlogStatus.joins(@@latestBlogStatusJoin).where("blog_statuses.status = '#{BlogStatus.rejected}'")
	end
end