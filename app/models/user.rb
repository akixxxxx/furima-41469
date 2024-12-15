class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 6, message: 'は6文字以上で入力してください' }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は英数字をそれぞれ含める必要があります' }
  validates :password, confirmation: true
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :family_name
    validates :given_name
  end
  validates :name_katakana, presence: true, format: { with: /\A[ァ-ンー－]+\z/ }
  validates :date_of_birth, presence: true
end
