class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.save
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
      user: current_user, item: @item
    )
  end
end
