require 'rails_helper'

describe "GET /show" do
  it "returns a successful response" do
    user = User.create!(name: 'Timmy')
    get users_url
    puts response.status
    expect(response).to be_successful
  end

  it 'renders a correct template' do
    user = User.create!(name: 'Timmy')
    get users_url
    puts response.status
    expect(response.body).to match(/This is a list of users/i)
  end
end