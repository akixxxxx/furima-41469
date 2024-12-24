require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '新規登録' do
    context '新規出品登録できるとき' do
      it 'すべて入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規登録できないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品名が空では登録できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product name can't be blank"
      end
      it '商品名が40文字以上だと登録できない' do
        @item.product_name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('Product name is too long (maximum is 40 characters)')
      end
      it '商品説明が空だと登録できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product description can't be blank"
      end
      it '商品説明が1000文字以上だと登録できない' do
        @item.product_description = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('Product description is too long (maximum is 1000 characters)')
      end
      it 'カテゴリーが未選択だと登録できない' do
        @item.category_information_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category information can't be blank!")
      end
      it '商品の状態が未選択だと登録できない' do
        @item.product_condition_information_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition information can't be blank!!")
      end
      it '配送料の負担が未選択だと登録できない' do
        @item.shipping_cost_information_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost information can't be blank!!!")
      end
      it '発送元の地域が未選択だと登録できない' do
        @item.shipping_origin_information_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping origin information can't be blank!!!!")
      end
      it '発送までの日数が未選択だと登録できない' do
        @item.shipping_time_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time can't be blank!!!!!")
      end
      it '価格が300円以下では登録できない' do
        @item.pricing_information = '150'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Pricing information must be between ¥300 and ¥9,999,999'
      end
      it '価格が1000万以上だと登録できない' do
        @item.pricing_information = '10000001'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Pricing information must be between ¥300 and ¥9,999,999'
      end
      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.pricing_information = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Pricing information must be between ¥300 and ¥9,999,999'
      end
      it 'ユーザー情報がない場合は登録できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
