class Team < ActiveRecord::Base
  has_many :users
  has_many :root_objectives, -> { roots }, through: :users,
                                           source: :objectives
end
