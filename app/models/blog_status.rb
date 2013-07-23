class BlogStatus < ActiveRecord::Base
	def self.pending
		"pending"
	end

	def self.approved
		"approved"
	end

	def self.rejected
		"rejected"
	end

	def self.acceptablestatus(status)
		if status == BlogStatus.pending || status == BlogStatus.approved || status == BlogStatus.rejected
			true
		else
			false
		end
	end
	
	attr_accessible :id, :blog_id, :status, :date
	belongs_to :blog, :class_name => "Blog", :foreign_key => "blog_id", :primary_key => "id"
end