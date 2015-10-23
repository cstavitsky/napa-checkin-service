require 'spec_helper'

def app
  ApplicationApi
end

describe RedemptionsApi do
  include Rack::Test::Methods

  context "POST /redemptions" do 

  	let(:ash) { User.create!(name:"Ash Ketchum", email: "ash@oaklab.com") }
    let(:store) { Location.create!(store_name: "711") }
  	let(:coffee_reward) { Reward.create!(name: "free coffee", point_value: 2) }

      	it 'redeems points for a reward' do 
      		Checkin.check_in(ash.id, store.id, 5)
      		p points = Checkin.points(ash.id, store.id)
      		redemptions = [{ user_id: ash.id, location_id: store.id, reward_id: 1 } ]
      		post "/redemptions", redemptions.to_json, 'CONTENT_TYPE' => 'application/json'
      		expect(last_response.body).to eq(201)
      	end
   end

end
