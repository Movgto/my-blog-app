require 'rails_helper'
describe 'posts views' do
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


  context 'index', type: :system do
    let(:path) { "/users/#{user.id}/posts" }

    it 'can see the profile picture of the user' do
      visit path

      photo = find(:css, '.user-photo')

      expect(photo).to_not be_nil
    end

    it 'can see the username' do
      visit path
      puts user.name
      find(:css, '.user-photo')

      expect(page).to have_content(user.name)
    end


    it 'can see number of posts of the user' do
      visit path
      puts user.posts_counter
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it 'can see the post\'s title' do
      visit path
      posts = [post1, post2, post3]

      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'can see the post\'s body' do
      visit path
      posts = [post1, post2, post3]

      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see the post\'s first comments' do
      visit path
      comments = [comment1, comment2, comment3]

      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'can see how many comments a post has' do
      visit path

      page.all(:css, '.post-counters').each do |elem|
        expect(elem.text).to match('Comments: 1')
      end
    end

    it 'can see how many likes a post has' do
      visit path

      page.all(:css, '.post-counters').each do |elem|
        expect(elem.text).to match('Likes: 1')
      end
    end

    it 'redirects to the post page when clicking a post' do
      visit path
      sleep(2)
      post_link = first(:css, '.post-nav-link')
      post_link.click do
        expect(page).to have_current_path("/users/#{user.id}/posts/#{post1.id}")
      end
    end
  end


  context 'show' do
    let(:path) { "/users/#{user.id}/posts/#{post1.id}" }

    it 'can see the post\'s title' do
      visit path

      expect(page).to have_content(post1.title)
    end

    it 'can see the user profile picture' do
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

    it 'can see how many likes it has' do
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
end
