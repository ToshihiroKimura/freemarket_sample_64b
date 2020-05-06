class UsersController < ApplicationController
  before_action :set_category_pull
  before_action :set_adress

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

  def set_adress
    if Address.where(user: current_user).present?
      @address = Address.where(user: current_user)
    else
      redirect_to new_address_path, alert: '住所を登録してください'
    end
  end
end