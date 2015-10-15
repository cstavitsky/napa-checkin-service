require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  	  context "GET /users" do
        it "returns an empty array of users" do
          get "/users"
          expect(last_response.status).to eq(200)
          expect(JSON.parse(response.body)).to eq({"data" => []})
        end
      end

      context "GET /users/:id" do
        it "returns a user by id" do
          user = User.create!
          get "/users/#{user.id}"
          expect(last_response.body).to eq(user.to_json)
        end
      end

      context "POST /users" do 
      	it 'creates many users' do 
      		users = [{ name: '...', email: 'a@a.com' }, { name: '...', email: 'b@b.com' }]
      		post "/users", users.to_json, 'CONTENT_TYPE' => 'application/json'
      		expect(last_response.body).to eq(201)
      	end
      end

end
