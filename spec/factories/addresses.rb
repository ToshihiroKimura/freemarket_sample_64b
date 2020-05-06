FactoryBot.define do

  factory :address do
    postcode              {"1234567"}
    prefecture            {1}
    city                  {"網走市"}
    block                 {"テスト1-1-1"}
    building              {"テックエキスパート101"}
    phone_number          {"09012345678"}
  end
end