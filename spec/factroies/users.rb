FactoryBot.define do

  factory :user do
    last_name             {'田中'}
    first_name            {"太郎"}
    last_name_kana        {"タナカ"}
    first_name_kana       {"タロウ"}
    nickname              {"taro"}
    birthday              {"2020/1/13"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end

end