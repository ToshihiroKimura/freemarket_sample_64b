class ItemsController < ApplicationController
  before_action :set_item_information,only:[:show,:destroy]
  require "payjp"
  before_action :set_card, only:[:buy_confirmation, :payment, :buy_complete]
  before_action :set_pay_jp_api_key, only: [:payment]
  before_action :set_category_pull

  def index
   @items = Item.includes(:images).order('created_at DESC').limit(3)
   @parents = Category.where(ancestry: nil).order("id ASC").limit(13)
  end

  def new
    @item = Item.new
    @item.images.build
    @category_parent = ["---"]
    @category_parent= Category.where(ancestry: nil).each do |parent|
    @category_parent<<parent.name
    end
  end

  def category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:child_name]).children
  end

  def create
    @item=Item.new(item_params)
    @category_parent = ["---"]
    @category_parent= Category.where(ancestry: nil).each do |parent|
    @category_parent<<parent.name
    end
    if @item.save
      redirect_to root_path , alert: '商品を出品しました'
    else
      @item.images.build
      render :new 
    end
  end

  def update
    @item = Item.find(params[:id])
    @images = @item.images
    begin
      @item.update!(item_params)
    rescue
      @item = Item.find(params[:id])
      @images = @item.images
      @item.update(except_image)
    end
    if @images.length >= 2
      @images.first.destroy
    end
    redirect_to item_path, alert: '商品情報を変更しました'
  end

  def show
  end

  def edit
    @item = Item.includes(:images).find(params[:id])
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @category_child_array = @item.category.parent.parent.children
    @category_grandchild_array = @item.category.parent.children
  end

  def destroy
    @item.destroy
    redirect_to root_path alert: '商品を削除しました'
  end



  def buy_confirmation
    @item = Item.find(params[:id])
    if Address.where(user: current_user).present?
      @address = Address.where(user: current_user)
      @prefecture = Prefecture.find(@address[:prefecture])
      if @card.present?
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @card_information = customer.cards.retrieve(@card.card_id)
        @card_brand = @card_information.brand
        case @card_brand
        when "Visa"
          @card_src = "visa.svg"
        when "JCB"
          @card_src = "jcb.svg"
        when "MasterCard"
          @card_src = "master-card.svg"
        when "American Express"
          @card_src = "american_express.svg"
        when "Diners Club"
          @card_src = "dinersclub.svg"
        when "Discover"
          @card_src = "discover.svg"
        end
      else
        redirect_to new_card_path,alert: 'カード情報を登録してください'
      end
    else
      redirect_to new_address_path,alert: '住所を登録してください'
    end
  end

  def payment
    @item = Item.find(params[:id])
    Payjp::Charge.create(
    amount: @item.price, 
    customer: @card.customer_id,
    currency: 'jpy', 
    )

    @item.update(buyer_id: current_user.id)

    redirect_to buy_complete_item_path
  end

  def buy_complete
  end


  private

  def set_category_pull
    @parents = Category.where(ancestry: nil).order("id ASC").limit(13)
  end
  
  def item_params
    params.require(:item).permit(:name,:text,:item_status,:price,:delivery_area,:delivery_charge,:delivery_days,:brand,:category_id,images_attributes: [:image, :id]).merge(solder_id: current_user.id)
  end

  def except_image
    params.require(:item).permit(:name,:text,:item_status,:price,:delivery_area,:delivery_charge,:delivery_days,:brand,:category_id).merge(solder_id: current_user.id)
  end

  def set_item_information
    @item = Item.find(params[:id])
    @image = @item.images.first
    @images = @item.images.all
    @solder=User.find(@item[:solder_id])
    @grandchild_category = Category.find(@item[:category_id])
    @child_category = @grandchild_category.parent
    @parent_category = @child_category.parent
    @delivery_area= Prefecture.find(@item[:delivery_area])

  end

  def set_card
    @card = Card.where(user: current_user).first if Card.where(user: current_user).present?
  end

  def set_pay_jp_api_key
    # ここはテスト秘密鍵をセットします。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  end
end

