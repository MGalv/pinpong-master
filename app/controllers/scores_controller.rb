class ScoresController < ApplicationController

  def index
    @scores = current_user.scores
  end
end
