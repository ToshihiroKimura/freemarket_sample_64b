class ItemsController < ApplicationController
  before_action :set_item_information,only:[:show,:destroy]
  require "payjp"
  before_action :set_card, only:[:buy_confirmation, :payment, :buy_complete]
  before_action :set_pay_jp_api_key, only: [:payment]

  def index
   @items = Item.includes(:images).order('created_at DESC').limit(3)
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
      redirect_to root_path , alert: '出品しました'
    else
      render :new 
    end
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    redirect_to root_path(item.id)
  
  end

  def show
  end

  def edit
    @item = Item.includes(:images).find(params[:id])
    @category_parent = ["---"]
    @category_parent= Category.where(ancestry: nil).each do |parent|
      @category_parent<<parent.name
    end
  end

  def destroy
    if @item.solder_id == current_user.id
      @item.destroy
    end
    redirect_to root_path
  end



  def buy_confirmation
    @item = Item.find(params[:id])
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
      redirect_to new_card_path
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
  
  def item_params
    params.require(:item).permit(:name,:text,:item_status,:price,:delivery_area,:delivery_charge,:delivery_days,:brand_id,:category_id,images_attributes: [:image]).merge(solder_id: current_user.id)
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

