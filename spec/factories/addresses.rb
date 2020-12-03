FactoryBot.define do
  factory :address do
    zip { "MyString" }
    street { "MyString" }
    complement { "MyString" }
    neighborhood { "MyString" }
    city { "MyString" }
    uf { "MyString" }
    ibge_code { "MyString" }
    user { nil }
  end
end
