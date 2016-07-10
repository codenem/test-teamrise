class Objective < ActiveRecord::Base
  belongs_to :owner, class_name: User
  belongs_to :parent, class_name: Objective
  has_many :children, class_name: Objective, foreign_key: :parent_id
end
