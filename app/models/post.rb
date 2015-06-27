class Post < ActiveRecord::Base
  has_attached_file :post_image, :styles => { :main => "500x600>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :post_image, :content_type => ['image/jpeg']

  VALID_STATES = %w[active pending_approval deleted rejected]

  validates_inclusion_of :state, in: VALID_STATES

  scope :active, -> { where(state: :active) }

  after_initialize do
    self.state ||= 'pending_approval'
  end

  def destroy
    self.state = :deleted
    save
  end

end
