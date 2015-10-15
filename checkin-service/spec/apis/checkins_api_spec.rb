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
          expect(JSON.parse(last_response.body)).to eq({"data" => []})
        end
      end

      context "GET /checkins/:id" do
        it "returns a checkin by id" do
          checkin = Checkin.create!(user_id: 1, location_id: 1, points: 5)
          p checkin.object_type 
          get "/checkins/#{checkin.id}"
          # p last_response.body
          checkin["test"] = "hello"
          expect(last_response.body).to eq("{\"data\": " + checkin.to_json + "}")
        end
      end

      context "POST /checkins" do 
      	it 'creates many checkins' do 
      		checkins = [{ user_id: 1, location_id: 1, points: 5 }, { user_id: 2, location_id: 2, points: 5 }]
      		post "/checkins", checkins.to_json, 'CONTENT_TYPE' => 'application/json'
      		expect(last_response.status).to eq(201)
      	end
      end

end
