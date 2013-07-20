class Blog < ActiveRecord::Base
	attr_accessible :id, :name, :description, :url, :owner_email
	belongs_to :user, :class_name => "User", :foreign_key => "owner_email", :primary_key => "email"
end