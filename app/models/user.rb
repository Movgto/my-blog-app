class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments
  has_many :likes
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  after_initialize :set_defaults

  def set_defaults
    self.posts_counter = Post.includes(:user).where(user: self).references(:user).count
    self.role ||= 'user'
  end

  def recent_posts
    posts.order('created_at DESC').limit(3)
  end
end
