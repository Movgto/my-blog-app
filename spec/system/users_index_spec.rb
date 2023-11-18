require 'rails_helper'

describe 'users index', type: :system do
  let(:user) { User.new(name: 'Diego', bio: 'Hi I\'m a student from Mexico', photo: 'https://as1.ftcdn.net/v2/jpg/00/64/30/06/1000_F_64300613_1TYCvyzq09Go7oEVXkDQypofuaJEwKTo.jpg') }
  let(:post1) { Post.new(author: user, title: 'Post 1', text: 'Post content') }
  let(:post2) { Post.new(author: user, title: 'Post 2', text: 'Post content') }
  let(:post3) { Post.new(author: user, title: 'Post 3', text: 'Post content') }

  before :each do
    user.save
    post1.save
    post2.save
    post3.save
  end

  it 'can see the username of all users' do
    visit users_path
    puts user.name
    find(:css, '.user-photo')

    expect(page).to have_content(user.name)
  end

  it 'can see the profile picture for each user' do
    visit users_path
    photo = find(:css, '.user-photo')

    expect(photo).to_not be_nil
  end

  it 'can see number of posts for each user' do
    visit users_path
    puts user.posts_counter
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'redirects to the user page when clicking the link of an user' do
    visit users_path
    user_link = find(:css, '.user-nav-link')
    user_link.click do
      expect(page).to have_current_path("/users/#{user.id}")
    end
  end
end
