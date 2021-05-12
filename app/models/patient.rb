class Patient < ApplicationRecord
  has_many :consultations 
  has_many :doctors, through: :consultations, foreign_key: :patient_id

  validates :name, presence: true, length: { maximum: 100 }
  ID_CARD_NUMBER_FORMAT = /\A([A-Z]){2}[0-9]{6}\z/
  validates :id_card_number, presence: true, format: { with: ID_CARD_NUMBER_FORMAT }
  PNC_FORMAT = /\A([1256])([0-9]){2}(0[1-9]|1[0-2])([0-2][0-9]|3[01])([0-9]){6}\z/
  validates :personal_numerical_code, presence: true, format: { with: PNC_FORMAT }, uniqueness: true
  validates :date_of_birth, presence: true
  validates :address, presence: true, length: { maximum: 255 }
end
