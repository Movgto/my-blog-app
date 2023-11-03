require 'rails_helper'

describe Post, type: :model do
  subject { User.new(name: 'Tommy') }
  let(:post) { Post.new(author: subject, title: 'Post 1', text: 'Post content') }

  before do
    subject.save
    post.save
  end
  
  it 'title should be present' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    invalid_title = ''
    for a in 1..252 do
      invalid_title += 'a'
    end
    post.title = invalid_title
    expect(post).to_not be_valid
  end

  it 'counters should be greater than or equal zero' do
    post.comments_counter = -1
    post.likes_counter = -1
    expect(post).to_not be_valid
  end
end