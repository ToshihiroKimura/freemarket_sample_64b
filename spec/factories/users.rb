FactoryBot.define do

  factory :user do
    last_name             {'田中'}
    first_name            {"太郎"}
    last_name_kana        {"タナカ"}
    first_name_kana       {"タロウ"}
    nickname              {"taro"}
    birthday              {"2020/1/13"}
    email                 {"kkk@gmail.com"}
    password              {"aaa00000"}
    password_confirmation {"aaa00000"}
  end

end