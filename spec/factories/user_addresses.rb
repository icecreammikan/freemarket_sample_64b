FactoryBot.define do
  factory :user_address do
    a_last_name               {"山下"}
    a_first_name              {"智也"}
    a_last_name_kana          {"ヤマシタ"}
    a_first_name_kana         {"トモヤ"}
    postcode                  {"0000000"}
    prefecture_id             {1}
    city                      {"あいうえお市"}
    address                   {"12-34"}
    association               :user
  end
end
