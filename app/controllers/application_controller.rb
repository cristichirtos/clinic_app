class ApplicationController < ActionController::Base
  before_action :logged_in_user, only: :home

  def home
    case @authentication_service.current_user.type 
    when 'Secretary'
      redirect_to consultations_path
    when 'Doctor'
      redirect_to consultations_path
    when 'Admin'
      redirect_to users_path
    else
      #Wait a minute, who are you?
    end
  end

  private

    def logged_in_user
      @authentication_service ||= AuthenticationService.new(session)
      unless @authentication_service.logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to login_path
      end
    end
end
