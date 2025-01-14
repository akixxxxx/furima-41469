class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_invalid_user, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    Rails.logger.debug "Order params: #{order_params.inspect}"
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :shipping_origin_information_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述
    Payjp::Charge.create(
      amount: @item.pricing_information,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_invalid_user
    if current_user.id == @item.user_id
      redirect_to root_path

    elsif @item.purchase_record.present?
      redirect_to root_path

    end
  end
end
