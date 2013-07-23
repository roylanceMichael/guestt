class BlogownerController < ApplicationController
	@@joinString = %{join (
					select blog_id as blog_id, max(date) as date
						from guestt.blog_statuses
					group by blog_id		
				) b
				on blog_statuses.blog_id = b.blog_id and blog_statuses.date = b.date}

	def createstatus(blog_id, status)
		newStatus = BlogStatus.new
		newStatus.blog_id = blog_id
		newStatus.status = status
		newStatus.date = Time.now
		newStatus.save
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

		createstatus(blog_id, status)

		render :json => { :success => "true" }
	end

	def blogs
		render :json => BlogStatus.joins(@@joinString).to_json(:include => [:blog])
	end

	def index
		redirect_to blogowner_approved_path
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

		createstatus(newBlog.id, BlogStatus.pending)

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