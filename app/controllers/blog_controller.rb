class BlogController < ApplicationController
	
	# simple search for right now, just looking for name
	def searchblogs
		searchTerms = params[:searchTerms]
		
		if searchTerms == nil
			render json: BlogStatus
			.joins(@@latestBlogStatusJoin)
			.where("status = :approved", {:approved => "#{BlogStatus.approved}"})
			.to_json(:include => [:blog])
		else
			render json: BlogStatus
			.joins(@@latestBlogStatusJoinWithBlog)
			.where("c.name like :searchTerms and status = :approved", {:searchTerms => "%#{searchTerms}%", :approved => "#{BlogStatus.approved}"})
			.to_json(:include => [:blog])
		end
	end
end