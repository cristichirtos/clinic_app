class Patient < ApplicationRecord
  has_many :consultations 
  has_many :doctors, through: :consultations, foreign_key: :patient_id
end
