class CardsController < ApplicationController
  
  require "payjp"
  Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] # APIキーの呼び出し
  # before_action :set_card, only: [:new]

  def new
    redirect_to action: "show" if @card.present?
  end

  def pay
    if params["payjp_token"].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(        # customerの定義、ここの情報を元に、カード情報との紐付けがされる
        card: params["payjp_token"]
      )

      @card = Card.create(                  # カードテーブルのデータの作成
        user_id: current_user.id,
        customer_id: customer.id,
        card_id: customer.default_card
      )
      if @card.save
        redirect_to root_path
      else
        redirect_to action: "new"
      end
    end
  end

  # def delete #PayjpとCardデータベースを削除
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #   else
  #     Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     customer.delete
  #     card.delete
  #   end
  #     redirect_to action: "new"
  # end

  def show #Cardのデータpayjpに送り情報を取り出す
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
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
  end
end