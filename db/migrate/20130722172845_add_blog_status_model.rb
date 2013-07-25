class AddBlogStatusModel < ActiveRecord::Migration
  def up
  	create_table(:blog_statuses) do |t|
  		t.integer :blog_id,              		:null => false
  		t.string :status,             			:null => false, :default => "pending" #other options include approved, rejected and sold
  		t.datetime :date,              			:null => false
  	end
  end

  def down
  	drop_table :blog_statuses
  end
end
