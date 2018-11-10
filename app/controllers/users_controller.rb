class UsersController < ApplicationController
  def index
    @users = User.ranked
  end
end
