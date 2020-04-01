class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:show, :edit, :update]
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.create(address_params)
    if @address.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if Address.update(address_params)
      render :show
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:postcode, :prefecture, :city, :block, :building, :phone_number).merge(user_id: current_user.id)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end