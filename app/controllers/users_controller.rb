class UsersController < ApplicationController
  before_action :set_services,   only: [:create, :show, :destroy]
  before_action :logged_in_user, only: [:index]
  before_action :admin_user,     only: [:index, :destroy, :edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = @user_service.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = @authentication_service.register(user_params)
    if @user.errors.empty?
      flash[:success] = 'Welcome to the Clinic App!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = @user_service.find_by_id(params[:id])
  end

  def update
    @user = @user_service.update_by_id(params[:id], user_params)
    if @user.errors.empty?
      flash[:success] = 'User updated.'
      redirect_to @user 
    else 
      render 'edit'
    end
  end

  def destroy
    @user_service.delete_by_id(params[:id])
    flash[:success] = 'User deleted.'
    redirect_to users_path
  end

  private 

    def set_services
      @user_service ||= UserService.new
      @authentication_service ||= AuthenticationService.new(session, @user_service)
    end

    def user_params 
      params.require(:user).permit(:username, :password, :password_confirmation, :name, :type)
    end

    def logged_in_user 
      set_services
      unless @authentication_service.logged_in?
        flash[:danger] = 'Please log in'
        redirect_to login_path
      end
    end

    def admin_user
      set_services
      redirect_to root_path unless @authentication_service.current_user.admin?
    end
end
