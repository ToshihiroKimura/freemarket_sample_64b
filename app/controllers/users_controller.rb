class UsersController < ApplicationController

  def new
  end

  def show
    user = User.find(params[:id])
    @email = user.email
    @items = user.items
  end
end