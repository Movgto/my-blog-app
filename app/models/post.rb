class Post < ApplicationRecord
  alias_attribute :author, :user
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :update_posts_counter

  def update_posts_counter
    user.posts_counter = user.posts.count
  end

  def recent_comments
    comments.first(5)
  end
end
