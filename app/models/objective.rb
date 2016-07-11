class Objective < ActiveRecord::Base
  # Store objectives as a nested set in the DB
  acts_as_nested_set depth_column: :level, touch: true
  belongs_to :owner, class_name: User

  scope :of_level, ->(level = nil) { level.blank? ? all : where(Objective.arel_table[:level].eq(level)) }
end
