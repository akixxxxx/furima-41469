FactoryBot.define do
  factory :user do
    nick_name             { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) }
    password_confirmation { password }
    family_name           { '山田' }
    given_name            { '県' }
    name_katakana         { generate_katakana }
    date_of_birth         { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end

def generate_katakana(length = 5)
  katakana_chars = %w[ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ
                      ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン]
  Array.new(length) { katakana_chars.sample }.join
end
