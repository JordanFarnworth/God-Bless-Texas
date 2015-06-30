class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg']
  has_many :posts
  has_secure_password
  has_many :login_sessions
  has_many :api_keys
  has_many :role_memberships
  has_many :roles, through: :role_memberships

  scope :active, -> { where(state: :active) }
  scope :deleted, -> { where(state: :deleted) }

  before_save :infer_values

  def infer_values
    self.state ||= :active
  end

  def admin?
    roles = self.roles
    unless roles.count == 0
      roles.each do |role|
        if role.name == "Admin"
          return true
        else
          return false  
        end
      end
    end
  end

  def active?
    state == 'active'
  end

  def has_image?
    return false if self.avatar_file_name == nil
  end

  def destroy
    self.state = 'deleted'
    save
  end
end
