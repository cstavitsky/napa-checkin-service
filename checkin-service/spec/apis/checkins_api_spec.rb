require 'spec_helper'

def app
  ApplicationApi
end

describe CheckinsApi do
  include Rack::Test::Methods

  	context "GET /checkins" do
        it "returns an empty array of checkins" do
          get "/checkins"
          expect(last_response.status).to eq(200)
          expect(JSON.parse(response.body)).to eq([])
        end
      end

      context "GET /checkins/:id" do
        it "returns a checkin by id" do
          checkin = Checkin.create!
          get "/checkins/#{checkin.id}"
          expect(last_response.body).to eq(checkin.to_json)
        end
      end

      context "POST /checkins" do 
      	it 'creates many checkins' do 
      		checkins = [{ user_id: 1, location_id: 1, points: 5 }, { user_id: 2, location_id: 2, points: 5 }]
      		post "/checkins", checkins.to_json, 'CONTENT_TYPE' => 'application/json'
      		expect(last_response.body).to eq(201)
      	end
      end

end
