require 'spec_helper'

describe Checkin do

  before(:each) do
  	@ash = User.create(name:"Ash Ketchum", email: "ash@oaklab.com")
  	@store = Location.create(store_name: "711")
  	@checkin = Checkin.create(@ash.id, @store.id)
  end

  it 'can be created' do
    checkin = create :checkin
    expect(checkin).to_not be_nil
  end

  describe '#points' do 

  	it 'should return the number of points for a given store/user combo' do
  		expect(Checkin.points(@ash.id, @store.id)).to be >= 0
  	end

  end

  describe '#check_in' do 

  	it 'should create a new instance of a Checkin' do 
  		checkin_count = Checkin.all.count
  		Checkin.check_in
  		expect(Checkin.all.count).to be > checkin_count
  	end
  	
  	it 'should add points to a Checkin after checking in' do
	  	initial_points = Checkin.points(@ash.id, @store.id)
	  	Checkin.check_in(@ash.id, @store.id)
	  	expect(Checkin.points(@ash.id, store.id)).to be > initial_points
	end
	
  end

  describe '#redeem_points' do
  	let(:coffee_reward) { Reward.create(point_value: 50, name: "free coffee") }

  	it 'should return false if user does not have enough points at this location' do
  		expect(Checkin.redeem_points(coffee_reward, @ash.id, @store.id)).to be_falsey
  	end

  	it 'should add a new Checkin if user has enough points' do 
  		11.times do |i|
  			@checkin.check_in(@ash.id, @store.id)
  		end
  		expect(Checkin.redeem_points(coffee_reward, @ash.id, @store.id)).to be_truthy
  	end

  	it 'should add a new Checkin with negative points equal to reward point_value' do 
  		11.times do |i|
  			@checkin.check_in(@ash.id, @store.id)
  		end
  		Checkin.redeem_points(coffee_reward, @ash.id, @store.id)
  		expect(Checkin.points).to eq(5)
  	end
  end

end
