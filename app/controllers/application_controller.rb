class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login

  # From http://guides.rubyonrails.org/action_controller_overview.html
  # and http://stackoverflow.com/questions/6209663/how-to-skip-a-before-filter-for-devises-sessionscontroller
  def require_login
    puts params[:controller]
    puts "controller is set to: #{controller_name}"
    #unless params[:controller] == 'devise/sessions'
    unless controller_name == 'sessions' or controller_name == 'home'
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path # halts request cycle
      end
    end
  end

end
