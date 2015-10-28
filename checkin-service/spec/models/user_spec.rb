require 'spec_helper'

describe User do
  let(:ash) { User.create(name: 'Ash Ketchum', email: 'ash@oaklab.com') }

  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

  it 'has a name that is a string' do
    expect(ash.name).to eq('Ash Ketchum')
  end

  it 'has an email that is a string' do
    expect(ash.email).to eq('ash@oaklab.com')
  end
end
