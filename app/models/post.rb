class Post < ApplicationRecord
  alias_attribute :author, :user
  belongs_to :user, foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

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
    likes_count = Like.includes(:post).where(post: self).references(:post).count
    comments_count = Comment.includes(:post).where(post: self).references(:post).count
    if likes_count >= 0 && comments_count >= 0
      self.likes_counter = likes_count
      self.comments_counter = comments_count
    else
      self.likes_counter = 0
      self.comments_counter = 0
    end
  end

  def update_posts_counter
    user.posts_counter = user.posts.count
  end

  def recent_comments
    comments.order('created_at ASC').limit(5)
  end
end
