require 'rails_helper'

describe Comment, type: :model do
  subject { User.new(name: 'Tommy') }
  let(:post) { Post.new(author: subject, title: 'Post 1', text: 'Post content') }
  let(:comment) { Comment.new(post: post, user: subject, text: 'This is a comment') }

  before do
    subject.save
    post.save
    comment.save
  end

  it 'updates post comments counter' do
    expect(post.comments_counter).to eq(1)
  end
end