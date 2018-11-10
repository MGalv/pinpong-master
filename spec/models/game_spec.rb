require 'spec_helper'

describe Game, type: :model do
  let(:user_a) { create(:user, email: "test@test.com") }
  let(:user_b) { create(:user, email: "test2@test.com") }
  let(:score_a) { create(:score, points: 1, user_id: user_a.id) }
  let(:score_b) { create(:score, points: 3, user_id: user_b.id) }
  let(:game) { build(:game) }

  before do
    game.scores << score_a
    game.scores << score_b
  end

  describe '#max_score' do
    it 'should return the max score' do
      expect(game.max_score).to eq(score_b)
    end
  end

  describe '#min_score' do
    it 'should return the min score' do
      expect(game.min_score).to eq(score_a)
    end
  end

  describe '#loser' do
    it 'should return user with the smaller score' do
      expect(game.loser).to eq(user_a)
    end
  end

  context 'when no score is over 21' do
    describe '#score_over_21' do
      it 'the game should not be valid' do
        expect(game.valid?).to eq(false)
      end
    end
  end

  context 'when the score difference is under 2' do
    let(:score_a) { create(:score, points: 21, user_id: user_a.id) }
    let(:score_b) { create(:score, points: 22, user_id: user_b.id) }

    describe 'min_score_difference' do
      it 'the game should not be valid' do
        expect(game.valid?).to eq(false)
      end
    end
  end

  context 'when the score difference is under 2' do
    let(:score_a) { create(:score, points: 21, user_id: user_a.id) }

    before do
      game.scores
    end

    describe 'min_score_difference' do
      it 'the game should not be valid' do
        expect(game.valid?).to eq(false)
      end
    end
  end
end