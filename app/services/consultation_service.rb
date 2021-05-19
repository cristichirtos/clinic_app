class ConsultationService
  
  CONSULTATIONS_PER_PAGE = 10

  def all_for_secretary(page)
    Consultation.includes(:doctor, :patient).future.order('date_time ASC').paginate(page: page, per_page: CONSULTATIONS_PER_PAGE)
  end

  def all_for_doctor(doctor, page)
    doctor.consultations.includes(:patient).past.paginate(page: page, per_page: CONSULTATIONS_PER_PAGE)
  end

  def find_by_id(id)
    Consultation.includes(:doctor, :patient).find(id)
  end

  def create(params)
    doctor_username = params[:doctor][:username]
    patient_pnc = params[:patient][:personal_numerical_code]
    doctor = Doctor.includes(:consultations).find_by(username: doctor_username)
    patient = Patient.find_by(personal_numerical_code: patient_pnc)
    consultation = Consultation.new(doctor: doctor, patient: patient, date_time: params[:date_time])

    unless params[:date_time].blank?
      time = Time.parse(params[:date_time] + ' UTC')
      if doctor.present? && doctor.consultations.where(date_time: (time - 1.hour)..(time + 1.hour)).any?
        consultation.errors.add(:base, 'This doctor is unavailable for that time.')

        return consultation
      end
    end

    unless consultation.save
      consultation.doctor = Doctor.new(username: doctor_username)
      consultation.patient = Patient.new(personal_numerical_code: patient_pnc)
    end

    consultation
  end

  def update_by_id(id, params)
    doctor_username = params[:doctor][:username]
    patient_pnc = params[:patient][:personal_numerical_code]
    doctor = Doctor.find_by(username: params[:doctor][:username])
    patient = Patient.find_by(personal_numerical_code: params[:patient][:personal_numerical_code])
    consultation = Consultation.find(id)
    unless consultation.update(doctor: doctor, patient: patient, date_time: params[:date_time])
      consultation.doctor = Doctor.new(username: doctor_username)
      consultation.patient = Patient.new(personal_numerical_code: patient_pnc)
    end
    consultation
  end

  def delete_by_id(id)
    Consultation.delete(id)
  end
end
