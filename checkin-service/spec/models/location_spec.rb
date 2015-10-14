require 'spec_helper'

describe Location do

  it 'can be created' do
    location = create :location
    expect(location).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for Location!')
  end

end
