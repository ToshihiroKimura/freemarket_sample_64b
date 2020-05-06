class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :show, :update]
  
  def new
    if Address.where(user: current_user).present?
      redirect_to root_path, alart: 'すでに住所は登録されています'
    else
      @address = Address.new
    end
  end

  def create
    @address = Address.create(address_params)
    if @address.save
      redirect_to root_path, alert: 'アカウント情報を登録しました'
    else
      render :new
    end
  end

  def show
    @prefecture = Prefecture.find(@address[:prefecture])
  end

  def edit
  end

  def update
    if Address.update(address_params)
      redirect_to "/users/#{current_user.id}", alert: '変更しました'
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:postcode, :prefecture, :city, :block, :building, :phone_number).merge(user_id: current_user.id)
  end

  def set_address
    if current_user.id != Address.find(params[:id]).user_id
      redirect_to root_path
    end
    @address = Address.find(params[:id])
  end
end