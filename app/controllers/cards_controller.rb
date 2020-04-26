class CardsController < ApplicationController
  
  require "payjp"
  Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] # APIキーの呼び出し
  # before_action :set_card, only: [:new]

  def new
    redirect_to action: "show" if @card.present?
  end

  def pay

    customer = Payjp::Customer.create(        # customerの定義、ここの情報を元に、カード情報との紐付けがされる
      card: params['payjp_token']
    )

    @card = Card.create(                  # カードテーブルのデータの作成
      user_id: current_user.id,
      customer_id: customer.id,
    )
    binding.pry
    if @card.save
      redirect_to root_path
    else
      redirect_to action: "new"
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
    card = Card.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(card.customer_id)
    # @default_card_information = customer.cards.retrieve(card.card_id)
  end
end