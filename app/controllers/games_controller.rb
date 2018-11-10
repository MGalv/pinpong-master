class GamesController < ApplicationController

  before_action :load_users, only: [:new, :create]

  respond_to :html

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      respond_with @game, location: scores_path
    else
      flash[:errors] = @game.errors.messages
      render :new
    end
  end

  private

  def game_params
    params.required(:game).permit(:played_at, scores_attributes: [:user_id, :points])
  end

  def score_params(key)
    params[:scores].required(key).permit(:user_id, :points)
  end

  def load_users
    @users = User.where.not(id: current_user.id)
  end
end
