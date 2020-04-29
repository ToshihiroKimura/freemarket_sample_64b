class ItemsController < ApplicationController

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
    if @item.save!
      redirect_to root_path , alert: '出品しました'
    else
      render :new ,alert: '出品できませんでした'
    end
  end

  def show
    @item=Item.find(params[:id])
    @image = @item.images.first
    @images = @item.images.all
    @solder=User.find(@item[:solder_id])
    @grandchild_category = Category.find(@item[:category_id])
    @child_category = @grandchild_category.parent
    @parent_category = @child_category.parent
    @delivery_charge = Deliverycharge.find(@item[:delivery_charge])
    @delivery_area= Prefecture.find(@item[:delivery_area])
    @delivery_days= Deliverydays.find(@item[:delivery_days])
    @item_status=Itemstatus.find(@item[:item_status])

  end

  def edit
  end

  def buy_confirmation
  end

  def payment
  end

  def buy_complete
  end

  private
  
  def item_params
    params.require(:item).permit(:name,:text,:item_status,:price,:delivery_area,:delivery_charge,:delivery_days,:brand_id,:category_id,images_attributes: [:image]).merge(solder_id: current_user.id)
  end
  

end

