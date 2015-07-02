class Suggestion < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(state: :active) }
  scope :deleted, -> { where(state: :deleted) }
end
