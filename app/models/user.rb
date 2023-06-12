class User < ApplicationRecord
  
  has_secure_password
  validates :email, presence: true, uniqueness: true

  # get user coordinates based on provided city and state input
  geocoded_by :address
  after_validation :geocode
  has_many :car_washes

  def address
    [city, state].compact.join(", ")
  end
end
