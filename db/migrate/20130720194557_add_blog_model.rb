class AddBlogModel < ActiveRecord::Migration
  def up
  	create_table(:blogs) do |t|
  		t.string :name,              		:null => false, :default => ""
  		t.string :description,             	:null => true, :default => ""
  		t.string :url,              		:null => false, :default => ""
  		t.string :user_email,              :null => false, :default => ""
  	end
  end

  def down
  	drop_table :blogs
  end
end
