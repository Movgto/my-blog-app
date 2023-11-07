require 'rails_helper'

describe Post, type: :model do
  subject { User.new(name: 'Tommy') }
  let(:post) { Post.new(author: subject, title: 'Post 1', text: 'Post content') }
  let(:comment) { Comment.new(post:, user: subject, text: 'This is a comment') }

  before do
    subject.save
    post.save
    comment.save
  end

  it 'title should be present' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    invalid_title = ''
    (1..252).each do |_|
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

  it 'returns first 3 recent comments' do
    expect(post.recent_comments[0]).to eq(comment)
  end

  it 'updates user posts counter' do
    expect(subject.posts_counter).to eq(1)
  end
end
