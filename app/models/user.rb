class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'

  def recent_posts
    self.posts.first(3)
  end
end