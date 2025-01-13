require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_form = FactoryBot.build(:order_form, item: @item.id, user: @user.id)
  end

  describe '新規購入成功' do
    context '購入登録できるとき' do
      it 'すべて入力されていれば登録できる' do
        expect(@order_form).to be_valid
      end
      it 'カード情報と購入者情報が登録できていれば登録できる' do
        expect(@order_form).to be_valid
      end
    end

    context '購入登録できないとき' do
      it '郵便番号が空では登録できない' do
        @order_form.postal_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号にハイフンがないと登録できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '郵便番号は半角文字でないと登録できない' do
        @order_form.postal_code = '１２３４５６７'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '都道府県を選択がないと登録できない' do
        @order_form.shipping_origin_information_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Shipping origin information can't be blank"
      end
      it '市区町村がないと登録できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "City can't be blank"
      end
      it '番地がないと登録できない' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号がないと登録できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号は10桁以上11桁以内でないと登録できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号は半角文字でないと登録できない' do
        @order_form.phone_number = '１２３４５６７８９０'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is invalid'
      end
    end
  end
end
