class Objective < ActiveRecord::Base
  # Store objectives as a nested set in the DB
  acts_as_nested_set depth_column: :level, touch: true
  belongs_to :owner, class_name: User

  scope :of_level, ->(level = nil) { level.blank? ? all : where(Objective.arel_table[:level].eq(level)) }
  scope :done, ->(state = nil) {
    if state.nil?
      all
    else
      objectives = Objective.arel_table
      if state
        where(objectives[:progress_value].eq(objectives[:progress_target]))
      else
        where(objectives[:progress_value].lt(objectives[:progress_target]))
      end
    end
  }


  def children_progress
    return if self.leaf?

    sum = self.children.select(:progress_start, :progress_value, :progress_target).inject(0.0) do |sum, child|
      sum + child.progress
    end
    sum / self.children.size
  end

  def progress
    (progress_value - progress_start).to_f / (progress_target - progress_start)
  end
end
