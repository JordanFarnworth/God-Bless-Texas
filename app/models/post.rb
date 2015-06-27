class Post < ActiveRecord::Base

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
