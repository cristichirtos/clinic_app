class ConsultationsController < ApplicationController
  before_action :logged_in_user
  before_action :secretary_or_doctor_user, only: [:index, :show, :edit, :update]
  before_action :secretary_user, only: [:new, :create, :destroy]

  def index
    @consultations = @user.secretary? ? @consultation_service.all_for_secretary(params[:page]) 
                                      : @consultation_service.all_for_doctor(@user, params[:page])
  end

  def show
    @consultation = @consultation_service.find_by_id(params[:id])
  end

  def new 
    @consultation = Consultation.new
  end

  def create 
    @consultation = @consultation_service.create(consultation_params)
    if @consultation.errors.empty?
      flash[:success] = 'Consultation added.'
      send_notification("Patient #{@consultation.patient.name} scheduled for consultation on #{@consultation.date_time}")

      redirect_to root_path
    else
      render 'new'
    end
  end

  def check_in
    @consultation = @consultation_service.find_by_id(params[:id])
    send_notification("Patient #{@consultation.patient.name} has arrived for consultation")

    redirect_to root_path
    end
  end

  def edit 
    @consultation = @consultation_service.find_by_id(params[:id])
  end

  def update 
    @consultation = @consultation_service.update_by_id(params[:id], consultation_params)
    if @consultation.errors.empty?
      flash[:success] = 'Consultation updated.'
      redirect_to @consultation
    else
      render 'edit'
    end
  end

  def destroy 
    @consultation_service.delete_by_id(params[:id])
    flash[:success] = 'Consultation deleted.'
    redirect_to root_path
  end

  private

    def set_services
      @consultation_service ||= ConsultationService.new
      @authentication_service ||= AuthenticationService.new(session)
    end

    def logged_in_user
      set_services
      unless @authentication_service.logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to login_path 
      end
    end

    def secretary_or_doctor_user
      set_services
      @user = @authentication_service.current_user
      redirect_to root_path unless @user.secretary? || @user.doctor?
    end

    def secretary_user 
      set_services 
      @user = @authentication_service.current_user
      redirect_to root_path unless @user.secretary?
    end

    def consultation_params
      params.require(:consultation).permit({:doctor => [:username]}, {:patient => [:personal_numerical_code]}, :date_time)
    end

    def send_notification(message)
      notification = Notification.new(sender: @authentication_service.current_user.id, 
                                      content: message, 
                                      receiver: @consultation.doctor.id)
      ActionCable.server.broadcast('notifications', { sender: notification.sender, content: notification.content }) 
    end
end
