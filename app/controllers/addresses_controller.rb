class AddressesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @address = Address.new
  end

  def create
    Adress.create(address_params)
    redirect_to root_path
  end

  private
  def address_params
    params.require(:address).merge(user_id: current_user.id)
  end
end
