class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true
  validate :password_complexity

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :family_name
    validates :given_name
  end

  validates :family_name_yomi, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :given_name_yomi, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :date_of_birth, presence: true

  # validate :pricing_information_must_be_half_width_numeric

  private

  def password_complexity
    return unless password.present?

    errors.add :password, 'は6文字以上で入力してください' if password.length < 6
    return if password.match?(/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i)

    errors.add :password, 'は英数字をそれぞれ含める必要があります'
  end

  # def pricing_information_must_be_half_width_numeric
  # return if pricing_information.to_s.match?(/\A[0-9]+\z/)

  # errors.add(:pricing_information, 'は半角数字のみを含む場合でなければなりません')
  # end
end
