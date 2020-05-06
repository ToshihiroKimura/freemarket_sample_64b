class UsersController < ApplicationController
<<<<<<< HEAD
=======
  before_action :set_category_pull
>>>>>>> 6121195cc62e2defb7f34e359a35f2e34ea76fcb

  def new
    @user = current_user
  end

  def show
    user = User.find(params[:id])
    @email = user.email
    @items = user.items
    @user = current_user
  end


  private

  def set_category_pull
    @parents = Category.where(ancestry: nil).order("id ASC").limit(13)
  end
end