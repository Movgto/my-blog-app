require 'rails_helper'

describe 'GET /index' do
  let(:user) { User.create!(name: 'Timmy') }
  let(:post) { Post.create!(author: user, title: 'Post', text: 'Post content') }

  it 'returns a successful response' do
    get "/users/#{user.id}/posts"
    expect(response).to be_successful
  end
end

describe 'GET /show' do
  let(:user) { User.create!(name: 'Timmy') }
  let(:post) { Post.create!(author: user, title: 'Post', text: 'Post content') }

  it 'returns a successful response' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response).to be_successful
  end
end
