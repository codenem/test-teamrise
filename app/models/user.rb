class User < ActiveRecord::Base
  belongs_to :team
  has_many :objectives, foreign_key: :owner_id
end
