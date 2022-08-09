require 'rails_helper'


RSpec.describe "Flights Index Page" do
  it 'shows all flight numbers, airline for specific flight and ' do

    jetblue = Airline.create!(name: "JetBlue")
    tap = Airline.create!(name: "TAP")

    flight1 = Flight.create!(number: "7890", date: "08/03/97", departure_city: "LA", airline_id: "#{jetblue.id}" )
    flight2 = Flight.create!(number: "1234", date: "11/12/97", departure_city: "NYC", airline_id: "#{jetblue.id}" )

    pass1 = Passenger.create!(name: "Bob", age: 123)
    pass2 = Passenger.create!(name: "Ali", age: 12)
    pass3 = Passenger.create!(name: "Carl", age: 23)
    pass4 = Passenger.create!(name: "Bily", age: 9)

    PassengerFlight.create!(flight_id: flight1.id, passenger_id: pass1.id)
    PassengerFlight.create!(flight_id: flight1.id, passenger_id: pass2.id)
    PassengerFlight.create!(flight_id: flight2.id, passenger_id: pass3.id)
    PassengerFlight.create!(flight_id: flight2.id, passenger_id: pass4.id)

    visit "/flights"


    within "#Flights-#{flight1.id}" do
      expect(page).to have_content("#{flight1.number}")
      expect(page).to have_content("Bob")
      expect(page).to have_content("Ali")
      expect(page).to_not have_content("#{flight2.number}")
    end

    within "#Flights-#{flight2.id}" do
      expect(page).to have_content("#{flight2.number}")
      expect(page).to have_content("Carl")
      expect(page).to have_content("Bily")
      expect(page).to_not have_content("#{flight1.number}")
    end
  end

  it 'link to remove passenger from flight' do
    jetblue = Airline.create!(name: "JetBlue")
    tap = Airline.create!(name: "TAP")

    flight1 = Flight.create!(number: "7890", date: "08/03/97", departure_city: "LA", airline_id: "#{jetblue.id}" )
    flight2 = Flight.create!(number: "1234", date: "11/12/97", departure_city: "NYC", airline_id: "#{jetblue.id}" )

    pass1 = Passenger.create!(name: "Bob", age: 123)
    pass2 = Passenger.create!(name: "Ali", age: 12)
    pass3 = Passenger.create!(name: "Carl", age: 23)
    pass4 = Passenger.create!(name: "Bily", age: 9)

    PassengerFlight.create!(flight_id: flight1.id, passenger_id: pass1.id)
    PassengerFlight.create!(flight_id: flight2.id, passenger_id: pass2.id)
    PassengerFlight.create!(flight_id: flight2.id, passenger_id: pass3.id)
    PassengerFlight.create!(flight_id: flight2.id, passenger_id: pass4.id)
    visit "/flights"

    within "#Flights-#{flight1.id}" do
      expect(page).to have_button("Remove from Flight")
      click_on "Remove from Flight"
    end

    expect(current_path).to eq("/flights")

  end


end
