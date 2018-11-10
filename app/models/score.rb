class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  delegate :played_at, :opponent, :max_score, :min_score, to: :game

  validates :points, :user_id, presence: true

  enum status: [:lost, :won]

  def assign_points!(points)
    user.add_points!(points)
    update_attributes points_won: points, status: :won
  end
end
