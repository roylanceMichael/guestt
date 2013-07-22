class BlogownerController < ApplicationController
	@@joinString = %{join (
					select blog_id as blog_id, max(date) as date
						from guestt.blog_statuses
					group by blog_id		
				) b
				on blog_statuses.blog_id = b.blog_id and blog_statuses.date = b.date}

	def index
		redirect_to blogowner_approved_path
	end

	def newblog
	end

	def createblog
		if !user_signed_in? 
			return
		end

		newBlog = Blog.new
		newBlog.name = params[:name]
		newBlog.description = params[:description]
		newBlog.url = params[:url]
		newBlog.user_email = current_user.email
		newBlog.save

		newStatus = BlogStatus.new
		newStatus.blog_id = newBlog.id
		newStatus.status = BlogStatus.pending
		newStatus.date = Time.now
		newStatus.save

		redirect_to blogowner_pending_path
	end

	def approvedblogs
		@blog_statuses = BlogStatus.joins(@@joinString).where("blog_statuses.status = '#{BlogStatus.approved}'")
	end

	def pendingblogs
		@blog_statuses = BlogStatus.joins(@@joinString).where("blog_statuses.status = '#{BlogStatus.pending}'")
	end

	def rejectedblogs
		@blog_statuses = BlogStatus.joins(@@joinString).where("blog_statuses.status = '#{BlogStatus.rejected}'")
	end
end