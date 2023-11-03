class Post < ApplicationRecord
  alias_attribute :author, :user
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :likes_counter, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  
  after_initialize :set_defaults
  after_create :update_posts_counter

  def set_defaults
    self.likes_counter ||= 0
    self.comments_counter ||= 0
  end

  def update_posts_counter
    user.posts_counter = user.posts.count
  end

  def recent_comments
    comments.order('created_at DESC').limit(5)
  end
end
