class User < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :login_sessions
  has_many :api_keys
  has_many :role_memberships
  has_many :suggestions
  has_many :roles, through: :role_memberships
  has_many :favorites, :dependent => :destroy
  has_many :favorite_posts, :through => :favorites, :source => :post

  has_attached_file :avatar, :styles => { :medium => "300x300>", :prof_pic => "175x175>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg']
  has_many :posts

  validates :email, uniqueness: true, on: :create
  validates :username, uniqueness: true, on: :create

  scope :active, -> { where(state: :active) }
  scope :deleted, -> { where(state: :deleted) }

  before_save :infer_values

  def infer_values
    self.state ||= :active
  end

  def admin?
    roles.any? { |r| r.name == 'Admin' }
  end


  def commented_posts
    #posts = Post.active.joins("INNER JOIN comments ON comments.post_id = posts.id INNER JOIN users ON users.id = comments.user_id").where("users.id = ?", self.id).uniq
    posts = Post.active.joins(comments: :user).where(comments: { user_id: id }).uniq
  end

  def active?
    state == 'active'
  end

  def has_image?
    self.avatar_file_name != nil
  end

  def destroy
    self.state = 'deleted'
    save
  end
end
