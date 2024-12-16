require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nick name,password,password_confirmation,family_name,given_name,famiy_name_yomi,given_name_yomi,date_of_birthがあれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nick_nameが空では登録できない' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nick name can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456abc'
        @user.password_confirmation = '123456abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字をそれぞれ含める必要があります')
      end
      it 'passwordが英語だけでは登録できない' do
        @user.password = '1234567'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字をそれぞれ含める必要があります')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it '名前(名字)が空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '名前(名字)が半角文字が含まれている場合は登録できない' do
        @user.family_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end
      it '名前(名前)が空では登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end
      it '名前(名前)が半角文字が含まれている場合は登録できない' do
        @user.given_name = 'ken'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name 全角文字を使用してください')
      end
      it '読み仮名(名字)が空では登録できない' do
        @user.family_name_yomi = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name yomi can't be blank")
      end
      it '読み仮名(名字)が半角文字が含まれている場合は登録できない' do
        @user.family_name_yomi = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name yomi is invalid')
      end
      it '読み仮名(名前)が空では登録できない' do
        @user.given_name_yomi = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name yomi can't be blank")
      end
      it '読み仮名(名前)が半角文字が含まれている場合は登録できない' do
        @user.given_name_yomi = 'ken'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name yomi is invalid')
      end
      it 'passwordが全角文字を含むと登録できない' do
        @user.password = 'ｐａｓｓｗｏｒｄ123'
        @user.password_confirmation = 'ｐａｓｓｗｏｒｄ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字をそれぞれ含める必要があります')
      end
      it '誕生日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
