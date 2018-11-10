class Game < ActiveRecord::Base
  has_many :scores
  has_many :users, through: :scores

  validate :scores_count
  validate :score_over_21
  validate :min_score_difference

  after_create :define_winner!

  accepts_nested_attributes_for :scores

  def max_score
    scores.max_by(&:points)
  end

  def min_score
    scores.min_by(&:points)
  end

  def loser
    min_score.user
  end

  def opponent(user)
    (users - [user]).first
  end

  private

  def define_winner!
    points = loser.give_away_points
    max_score.assign_points!(points)
  end

  def score_over_21
    unless max_score.points >= 21
      errors.add(:min_score_not_reached, 'At least one score should be over 21 points.')
    end
  end

  def min_score_difference
    unless (max_score.points - min_score.points).abs >= 2
      errors.add(:score_difference, 'Each game needs to be won by a two point margin.')
    end
  end

  def scores_count
    unless scores.size == 2
      errors.add(:scores_count, 'Both users should have score points. ')
    end
  end
end
