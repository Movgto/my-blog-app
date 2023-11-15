require 'rails_helper'
describe 'users views' do
  context "index", type: :system do
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
    
    it "can see the username of all users" do
      visit users_path
      sleep(2)
      puts user.name
      photo = find(:css, '.user-photo')

      expect(page).to have_content(user.name)
    end

    it "can see the profile picture for each user" do
      visit users_path
      sleep(2)
      photo = find(:css, '.user-photo')
      
      expect(photo).to_not be_nil
    end

    it "can see number of posts for each user" do
      visit users_path
      sleep(2)
      puts user.posts_counter
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it "redirects to the user page when clicking the link of an user" do
      visit users_path
      sleep(2)
      user_link = find(:css, '.user-nav-link')
      user_link.click do
        expect(page).to have_current_path("/users/#{user.id}/posts")
      end
    end
  end

  context 'show' do
    let(:user) { User.new(name: 'Diego', bio: 'Hi I\'m a student from Mexico', photo: 'https://as1.ftcdn.net/v2/jpg/00/64/30/06/1000_F_64300613_1TYCvyzq09Go7oEVXkDQypofuaJEwKTo.jpg') }
    let(:post1) { Post.new(author: user, title: 'Post 1', text: 'Post content') }
    let(:post2) { Post.new(author: user, title: 'Post 2', text: 'Post content') }
    let(:post3) { Post.new(author: user, title: 'Post 3', text: 'Post content') }
    let(:comment1) { Comment.new(user: user, post: post1, text: 'Comment 1') }
    let(:comment2) { Comment.new(user: user, post: post2, text: 'Comment 2') }
    let(:comment3) { Comment.new(user: user, post: post3, text: 'Comment 3') }

    before :each do
      user.save
      post1.save
      post2.save
      post3.save
      comment1.save
      comment2.save
      comment3.save
    end

    it 'can see the user profile picture' do
      visit "/users/#{user.id}"
      img = find(:css, '.user-photo')
      expect(img).to_not be_nil
    end

    it 'can see the user profile picture' do
      visit "/users/#{user.id}"

      expect(page).to have_content(user.name)
    end

    it 'can see the number of posts of the user' do
      visit "/users/#{user.id}"

      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it 'can see the bio of the user' do
      visit "/users/#{user.id}"

      expect(page).to have_content(user.bio)
    end

    it 'can see the user\'s 3 most recent posts' do
      visit "/users/#{user.id}"

      expect(page).to have_content(post1.text)
      expect(page).to have_content(post2.text)
      expect(page).to have_content(post3.text)
    end

    it 'can see a button to see all posts' do
      visit "/users/#{user.id}"

      expect(page).to have_content("See all posts")
    end

    it 'clicking the button to see all posts redirects the user to the posts index page' do
      visit "/users/#{user.id}"

      click_link 'See all posts' do
        expect(page).to have_current_path("/users/#{user.id}/posts")
      end
    end
  end
end