class AddGuestToBlogStatus < ActiveRecord::Migration
  def change
    add_column :blog_statuses, :guest_email, :string, :null => true
  end
end
