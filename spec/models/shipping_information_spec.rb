require 'rails_helper'

RSpec.describe ShippingInformation, type: :model do
  before do
    @shipping_information = FactoryBot.build(:shipping_information)
  end

  describe '新規購入成功' do
    context '購入登録できるとき' do
      it 'すべて入力されていれば登録できる' do
        expect(@shipping_information).to be_valid
      end
    end

    context '購入登録できないとき' do
      it '郵便番号が空では登録できない' do
        @shipping_information.postal_code = nil
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号にハイフンがないと登録できない' do
        @shipping_information.postal_code = '1234567'
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '郵便番号は半角文字でないと登録できない' do
        @shipping_information.postal_code = '１２３４５６７'
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '都道府県を選択がないと登録できない' do
        @shipping_information.shipping_origin_information_id = nil
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include "Shipping origin information can't be blank"
      end
      it '市区町村がないと登録できない' do
        @shipping_information.city = nil
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include "City can't be blank"
      end
      it '番地がないと登録できない' do
        @shipping_information.address = nil
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号がないと登録できない' do
        @shipping_information.phone_number = nil
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号は10桁以上11桁以内でないと登録できない' do
        @shipping_information.phone_number = '123456789'
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号は半角文字でないと登録できない' do
        @shipping_information.phone_number = '１２３４５６７８９０'
        @shipping_information.valid?
        expect(@shipping_information.errors.full_messages).to include 'Phone number is invalid'
      end
    end
  end
end
