class UsersController < ApplicationController
  def destroy
    redirect_to root_path
  end

  def index
    @users = User.all
  end
end
