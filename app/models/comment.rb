class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  VALID_STATES = %w[active deleted]
  validates_presence_of :user
  validates_presence_of :post
  validates_inclusion_of :state, in: VALID_STATES

  before_validation :infer_values

  def infer_values
    self.state ||= :active
  end

  def destroy
    self.state = "deleted"
  end
end
