require 'spec_helper'

def app
  ApplicationApi
end

describe RewardsApi do
  include Rack::Test::Methods

  context 'GET /rewards' do
    it 'returns an empty array of rewards' do
      get '/rewards'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq('data' => [])
    end
  end

  context 'GET /rewards/:id' do
    it 'returns a reward by id' do
      reward = Reward.create!
      get "/rewards/#{reward.id}"
      expect(last_response.body).to eq(reward.to_json)
    end
  end

  context 'POST /rewards' do
    it 'creates many rewards' do
      rewards = [{ name: '...', point_value: 5, checkin_id: 1 }, { name: '...', point_value: 5, checkin_id: 2 }]
      post '/rewards', rewards.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.body).to eq(201)
    end
  end
end
