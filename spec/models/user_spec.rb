require 'rails_helper'

describe User, type: :model do
  subject { User.new(name: 'Tommy') }
  let(:post) { Post.new(author: subject, title: 'Post 1', text: 'Post content') }

  before do
    subject.save
    post.save
  end

  it 'should pass validations with a valid name' do
    expect(subject).to be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be greater than or equal 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent_posts returns a list of the 3 most recent posts' do
    return_recent_posts = subject.recent_posts
    expect(return_recent_posts[0].id).to eq(post.id)
  end
end
