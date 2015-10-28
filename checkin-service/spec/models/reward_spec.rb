require 'spec_helper'

describe Reward do
  let(:reward) { Reward.create(point_value: 50, name: 'free coffee') }
  it 'can be created' do
    reward = create :reward
    expect(reward).to_not be_nil
  end

  it 'has an integer point_value' do
    expect(reward.point_value).to be_a Integer
  end

  it 'has a string name' do
    expect(reward.name).to be_a String
  end
end
