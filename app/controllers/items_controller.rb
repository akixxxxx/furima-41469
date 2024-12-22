class ItemsController < ApplicationController
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :product_description, :category_information_id,
                                 :product_condition_information_id, :shipping_cost_information_id, :shipping_origin_information_id,
                                 :shipping_time_id, :pricing_information)
  end
end
