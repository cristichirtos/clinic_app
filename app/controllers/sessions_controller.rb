class SessionsController < ApplicationController
  before_action :set_services

  def new; end

  def create
    if @authentication_service.log_in(params[:session])
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    if @authentication_service.log_out 
      flash[:success] = 'Logged out successfully. See you next time!'
      redirect_to login_path
    else
      flash[:danger] = 'You have to be logged in before you can log out.'
    end
  end

  private 

    def set_services
      @user_service ||= UserService.new
      @authentication_service ||= AuthenticationService.new(session, @user_service)
    end
end
