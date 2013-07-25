class TestController < ApplicationController
	def populatedatabase
		# delete all the blog statuses
		query = "delete from blog_statuses"
		ActiveRecord::Base.connection.execute(query);

		# delete all the blogs
		query = "delete from blogs"
		ActiveRecord::Base.connection.execute(query);

		i = 0
		until i > 50  do
			newBlog = Blog.new
			newBlog.name = "#{randomname}'s blog"
			newBlog.description = randomstring(20)
			newBlog.user_email = current_user.email
			newBlog.url = "http://#{randomstring(5)}.com"
			newBlog.save

			# create the initial pending status
			createteststatus(newBlog.id, BlogStatus.pending, nil, Time.now - 900000)

			# do we go to accepted or rejected (33% each)?
			firstRes = rand
			if firstRes < 0.34
				# do we go to sold? 30% chance
				createteststatus(newBlog.id, BlogStatus.approved, nil, Time.now - 500000)

				secondRes = rand
				if secondRes < 0.31
					createteststatus(newBlog.id, BlogStatus.sold, current_user.email, Time.now - 100000)
				end
			elsif firstRes < 0.67
				createteststatus(newBlog.id, BlogStatus.rejected, nil, Time.now - 100000)
			end

			# increment
			i = i + 1
		end

		render :json => {:success => "true" }
	end

	def randomname
		names = ["JAMES", "JOHN", "ROBERT", "MICHAEL", "THOMAS", "CHARLES", "DAVID", "WILLIAM", "DANIEL", "ANTHONY", "KEVIN", "JOSE", "ERIC"]
		names[(rand * names.length).to_i].downcase
	end

	def randomstring(size)
		# probably better to static this, but oh well (only gets called in test)
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten

		# create a string of this size
		(0...size).map{ 
			# map the random value to our alphabet map
			o[rand(o.length)] 
			}
			.join
	end

    def createteststatus(blog_id, status, guest_email, datetime)
	    newStatus = BlogStatus.new
	    newStatus.blog_id = blog_id
	    newStatus.status = status
	    newStatus.date = datetime
	    newStatus.guest_email = guest_email
	    newStatus.save
  	end
end