class AuthenticationService

  def initialize(session, user_service = nil)
    @session = session
    @user_service = user_service
  end

  def register(params)
    params[:type] = 'Doctor' if params[:type].nil?
    user = @user_service.save(params)
    @session[:user_id] = user.id if user.errors.empty?
    user
  end

  def log_in(params)
    user = @user_service.find_by_username(params[:username])
    if user &.authenticate(params[:password])
      @session[:user_id] = user.id
      return true 
    end 

    false
  end

  def current_user 
    @current_user ||= User.find_by(id: @session[:user_id]) if @session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out 
    return false unless logged_in?

    @session.clear
    @current_user = nil 

    true
  end 
end 
