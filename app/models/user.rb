class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :scores
  has_many :games, through: :scores

  scope :ranked, -> { order('points desc') }
  scope :reverse_ranked, -> { order('points asc') }
  scope :with_points, -> { where('points > 0') }

  def add_points!(points)
    increment!(:points, points)
  end

  def give_away_points
    User.with_points.reverse_ranked.pluck(:id).index(id).to_i + 1
  end
end
