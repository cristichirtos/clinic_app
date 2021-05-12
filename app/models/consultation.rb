class Consultation < ApplicationRecord
  belongs_to :doctor, foreign_key: :doctor_id, class_name: 'Doctor'
  belongs_to :patient, foreign_key: :patient_id

  validates :date_time, presence: true

  scope :past, -> { where('date_time < ?', Time.now) }
  scope :future, -> { where('date_time > ?', Time.now) }
  scope :doctor, ->(doctor) { where(doctor: doctor) }
end
