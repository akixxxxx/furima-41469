require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_form = FactoryBot.build(:order_form, item_id: @item.id, user_id: @user.id)
  end

  describe '新規購入成功' do
    context '購入登録できるとき' do
      it 'すべて入力されていれば登録できる' do
        expect(@order_form).to be_valid
      end
      it '建物名が空でも登録できる' do
        @order_form.building_name = ''
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
      it '電話番号は10桁未満だと登録できない' do
        @order_form.phone_number = '1'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号は11桁以上だと登録できない' do
        @order_form.phone_number = '123456789091'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is invalid'
      end

      it '電話番号は半角文字でないと登録できない' do
        @order_form.phone_number = '１２３４５６７８９０'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is invalid'
      end

      it '都道府県に「---」が選択されている場合は購入できない' do
       @order_form.shipping_origin_information_id = '1'
       @order_form.valid?
       expect(@order_form.errors.full_messages).to include "Shipping origin information can't be blank"
      end
      it 'tokenが空では購入できない' do
       @order_form.token = nil
       @order_form.valid?
       expect(@order_form.errors.full_messages).to include "Token can't be blank"
      end
      it 'userが紐付いていなければ購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐付いていなければ購入できない' do
       @order_form.item_id = nil
       @order_form.valid?
       expect(@order_form.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
