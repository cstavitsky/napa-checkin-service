require 'spec_helper'

describe Reward do

  it 'can be created' do
    reward = create :reward
    expect(reward).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for Reward!')
  end

end
