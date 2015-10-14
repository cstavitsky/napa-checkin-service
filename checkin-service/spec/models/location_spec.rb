require 'spec_helper'

describe Location do
let(:store) { Location.new(name: "711") }

  it 'can be created' do
    location = create :location
    expect(location).to_not be_nil
  end

  it 'has a name that is a string' do
    expect(store.name).to eq("711")
  end

end
