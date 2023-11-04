require 'rails_helper'

describe Like, type: :model do
  subject { User.new(name: 'Tommy') }
  let(:user2) { User.new(name: 'Jimmy') }
  let(:post) { Post.new(author: subject, title: 'Post 1', text: 'Post content') }
  let(:comment) { Comment.new(post: post, user: subject, text: 'This is a comment') }
  let(:like) { Like.new(post: post, user: user2) }

  before do
    subject.save
    user2.save
    post.save
    comment.save
    like.save
  end

  it 'updates post likes counter' do
    expect(post.likes_counter).to eq(1)
  end
end