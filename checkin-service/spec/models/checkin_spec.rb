require 'spec_helper'

describe Checkin do
  let(:ash) { User.create(name: 'Ash Ketchum', email: 'ash@oaklab.com') }
  let(:store) { Location.create(store_name: '711') }
  let(:checkin) { Checkin.create(user_id: ash.id, location_id: store.id, points: 5) }

  it 'can be created' do
    checkin = create :checkin
    expect(checkin).to_not be_nil
  end

  describe '#points' do
    it 'should return the number of points for a given store/user combo' do
      expect(Checkin.points(ash.id, store.id)).to be >= 0
    end
  end

  describe '#check_in' do
    let(:ash) { User.create(name: 'Ash Ketchum', email: 'ash@oaklab.com') }
    let(:store) { Location.create(store_name: '711') }
    let(:checkin) { Checkin.create(user_id: ash.id, location_id: store.id, points: 5) }

    it 'should create a new instance of a Checkin' do
      checkin_count = Checkin.all.count
      Checkin.check_in(ash.id, store.id, 5)
      expect(Checkin.all.count).to be > checkin_count
    end

    it 'should add points to a Checkin after checking in' do
      initial_points = Checkin.points(ash.id, store.id)
      Checkin.check_in(ash.id, store.id, 5)
      expect(Checkin.points(ash.id, store.id)).to be > initial_points
    end
  end

  describe '#redeem_points' do
    let(:ash) { User.create(name: 'Ash Ketchum', email: 'ash@oaklab.com') }
    let(:store) { Location.create(store_name: '711') }
    let(:checkin) { Checkin.create(user_id: ash.id, location_id: store.id, points: 5) }
    let(:coffee_reward) { Reward.create(name: 'free coffee', point_value: 2) }

    it 'should return false if user does not have enough points at this location' do
      expect(Checkin.redeem_points(coffee_reward, ash.id, store.id)).to be_falsey
    end

    it 'should add a new Checkin if user has enough points' do
      Checkin.check_in(ash.id, store.id, 5)
      expect(Checkin.redeem_points(coffee_reward, ash.id, store.id)).to be_truthy
    end

    it 'should add a new Checkin with negative points equal to reward point_value' do
      #   11.times do |i|
      #     Checkin.check_in(ash.id, store.id, 5)
      # end
      Checkin.check_in(ash.id, store.id, 5)
      Checkin.redeem_points(coffee_reward, ash.id, store.id)
      expect(Checkin.points(ash.id, store.id)).to eq(3)
    end
  end
end
