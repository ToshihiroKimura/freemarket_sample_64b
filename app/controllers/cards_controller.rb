class CardsController < ApplicationController
  
  require "payjp"
  Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  before_action :set_card

  def new
    redirect_to "/cards/#{current_user.id}" if @card.present?
  end

  def pay
    if params["payjp_token"].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        card: params["payjp_token"]
      )

      @card = Card.create(
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

  def show
    if @card.present?
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
  
  def delete
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    @card.delete
    redirect_to "/users/#{current_user.id}"
  end

  def set_card
    @card = Card.where(user: current_user).first if Card.where(user: current_user).present?
  end
end