class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login

  @@latestBlogStatusJoin = %{join (
        select blog_id as blog_id, max(date) as date
          from guestt.blog_statuses
        group by blog_id    
      ) b
      on blog_statuses.blog_id = b.blog_id and blog_statuses.date = b.date}

  @@latestBlogStatusJoinWithBlog = %{join (
        select blog_id as blog_id, max(date) as date
          from guestt.blog_statuses
        group by blog_id    
      ) b
      on blog_statuses.blog_id = b.blog_id and blog_statuses.date = b.date
      join blogs c
        on blog_statuses.blog_id = c.id}

  # creates the status
  def createstatus(blog_id, status, guest_email)
    newStatus = BlogStatus.new
    newStatus.blog_id = blog_id
    newStatus.status = status
    newStatus.date = Time.now
    newStatus.guest_email = guest_email
    newStatus.save
  end

  # From http://guides.rubyonrails.org/action_controller_overview.html
  # and http://stackoverflow.com/questions/6209663/how-to-skip-a-before-filter-for-devises-sessionscontroller
  def require_login
    puts params[:controller]
    puts "controller is set to: #{controller_name}"
    #unless params[:controller] == 'devise/sessions'
    unless controller_name == 'sessions' or controller_name == 'home' or controller_name == 'registrations'
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path # halts request cycle
      end
    end
  end

end
