class Passenger < ApplicationRecord

  has_many :flights

  has_many :passenger_flights
  has_many :flights, through: :passenger_flights



end
