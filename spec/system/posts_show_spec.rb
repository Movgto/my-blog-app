require 'rails_helper'

describe 'posts show', type: :system do
  let(:user) { User.new(name: 'Diego', bio: 'Hi I\'m a student from Mexico', photo: 'https://as1.ftcdn.net/v2/jpg/00/64/30/06/1000_F_64300613_1TYCvyzq09Go7oEVXkDQypofuaJEwKTo.jpg') }
  let(:post1) { Post.new(author: user, title: 'Post 1', text: 'Post content') }
  let(:post2) { Post.new(author: user, title: 'Post 2', text: 'Post content') }
  let(:post3) { Post.new(author: user, title: 'Post 3', text: 'Post content') }
  let(:comment1) { Comment.new(user:, post: post1, text: 'Comment 1') }
  let(:comment2) { Comment.new(user:, post: post2, text: 'Comment 2') }
  let(:comment3) { Comment.new(user:, post: post3, text: 'Comment 3') }
  let(:like1) { Like.new(user:, post: post1) }
  let(:like2) { Like.new(user:, post: post2) }
  let(:like3) { Like.new(user:, post: post3) }
  let(:path) { "/users/#{user.id}/posts/#{post1.id}" }

  before :each do
    user.save
    post1.save
    post2.save
    post3.save
    comment1.save
    comment2.save
    comment3.save
    like1.save
    like2.save
    like3.save
  end


  it 'can see the post\'s title' do
    visit path

    expect(page).to have_content(post1.title)
  end

  it 'can see who wrote the post' do
    visit path

    expect(page).to have_content(user.name)
  end

  it 'can see how many comments it has' do
    visit path

    expect(page).to have_content("Comments: #{post1.comments_counter}")
  end

  it 'can see how many likes it has' do
    visit path

    expect(page).to have_content("Likes: #{post1.likes_counter}")
  end

  it 'can see the post body' do
    visit path

    expect(page).to have_content(post1.text)
  end

  it 'can see username of each commentor' do
    visit path

    expect(page).to have_content(comment1.user.name)
  end

  it 'can see the comment each commentor left' do
    visit path

    expect(page).to have_content(comment1.text)
  end
end
