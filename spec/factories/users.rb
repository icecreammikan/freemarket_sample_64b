FactoryBot.define do
  factory :user do
    nickname                {"やんち"}
    last_name               {"山下"}
    first_name              {"智也"}
    last_name_kana          {"ヤマシタ"}
    first_name_kana         {"トモヤ"}
    birthyear_id            {1}
    birthmonth_id           {1}
    birthday                {7}
    email                   {"a@example.com"}
    password                {"aaaa0000"}
    phone_number            {"09000000000"}
    authentication_number   {"1234"}
  end
end
