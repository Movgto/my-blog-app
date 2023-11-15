require 'rails_helper'

describe 'GET /index' do
  it 'returns a successful response' do
    get users_url
    puts response.status
    expect(response).to be_successful
  end
end

describe 'GET /show' do
  let(:user) { User.create!(name: 'Timmy') }
  it 'returns a successful response' do
    get "/users/#{user.id}"
    puts response.status
    expect(response).to be_successful
  end
end
