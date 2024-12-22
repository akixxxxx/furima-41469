class ItemsController < ApplicationController
  def index
    @item = Item.all
  end

  def new
    @item = Item.all
  end
end
