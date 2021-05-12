class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 100 }
  has_secure_password

  def admin?
    self.type == 'Admin'
  end

  def doctor?
    self.type == 'Doctor'
  end

  def secretary?
    self.type == 'Secretary'
  end
end
