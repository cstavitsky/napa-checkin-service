require 'spec_helper'

def app
  ApplicationApi
end

describe LocationsApi do
  include Rack::Test::Methods

      context "GET /locations" do
        it "returns an empty array of locations" do
          get "/locations"
          expect(last_response.status).to eq(200)
          expect(JSON.parse(last_response.body)).to eq({"data" => []})
        end
      end

      context "GET /locations/:id" do
        it "returns a location by id" do
          location = Location.create!
          get "/locations/#{location.id}"
          expect(last_response.body).to eq(location.to_json)
        end
      end

      context "POST /locations" do 
      	it 'creates many locations' do 
      		locations = [{ store_name: '...' }, { store_name: '...' }]
      		post "/locations", locations.to_json, 'CONTENT_TYPE' => 'application/json'
      		expect(last_response.body).to eq(201)
      	end
      end
end
