class RoleMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  before_save :infer_values

  def infer_values
    self.state ||= :active
  end
end
