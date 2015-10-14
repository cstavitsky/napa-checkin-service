require 'spec_helper'

describe Location do
let(:store) { Location.new(name: "711") }

  it 'can be created' do
    location = create :location
    expect(location).to_not be_nil
  end

  it 'has a store_name that is a string' do
    expect(store.store_name).to eq("711")
  end

end
