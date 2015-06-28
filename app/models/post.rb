class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :post_image, :styles => { :main => "500x600>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :post_image, :content_type => ['image/jpeg']

  VALID_STATES = %w[active pending_approval deleted rejected]

  validates_inclusion_of :state, in: VALID_STATES

  scope :active, -> { where(state: :active) }
  scope :pending_approval, -> { where(state: :pending_approval) }
  scope :deleted, -> { where(state: :deleted) }
  scope :rejected, -> { where(state: :rejected) }

  after_initialize do
    self.state ||= 'pending_approval'
  end

  def destroy
    self.state = :deleted
    save
  end

  def image
    self.post_image.url
  end

end
