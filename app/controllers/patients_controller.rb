class PatientsController < ApplicationController
  before_action :set_services, only: [:show]
  before_action :logged_in_user
  before_action :secretary_user

  def index
    @patients = Patient.paginate(page: params[:page])
  end

  def show
    @patient = @patient_service.find_by_id(params[:id])
  end

  def new 
    @patient = Patient.new 
  end

  def create 
    @patient = @patient_service.create(patient_params)
    if @patient.errors.empty?
      flash[:success] = 'Patient added!'
      redirect_to root_path 
    else
      render 'new'
    end
  end

  def edit 
    @patient = @patient_service.find_by_id(params[:id])
  end

  def update 
    @patient = @patient_service.update_by_id(params[:id], patient_params)
    if @patient.errors.empty?
      flash[:success] = 'Patient updated!'
      redirect_to @patient 
    else
      render 'edit'
    end
  end

  def destroy
    @patient_service.delete_by_id(params[:id])
    flash[:success] = 'Patient deleted.'
    redirect_to users_path
  end

  private 

    def set_services 
      @authentication_service ||= AuthenticationService.new(session)
      @patient_service ||= PatientService.new
    end

    def logged_in_user 
      set_services
      unless @authentication_service.logged_in?
        flash[:danger] = 'Please log in'
        redirect_to login_path
      end
    end

    def secretary_user
      set_services
      redirect_to root_path unless @authentication_service.current_user.secretary?
    end

    def patient_params
      params.require(:patient).permit(:name, :id_card_number, :personal_numerical_code, :date_of_birth, :address)
    end
end
