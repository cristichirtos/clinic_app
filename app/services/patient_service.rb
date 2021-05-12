class PatientService 

  def find_by_id(id)
    Patient.find(id)
  end

  def create(params)
    patient = Patient.new(params)
    patient.save
    patient
  end

  def update_by_id(id, params)
    patient = Patient.find(id)
    patient.update(params)
    patient
  end

  def delete_by_id(id)
    Patient.delete(id)
  end
end
