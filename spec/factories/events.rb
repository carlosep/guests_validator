FactoryBot.define do
  factory :event do
    name { "MyString" }
    starts_at { "2019-03-24" }
    ends_at { "2019-03-24" }
    tolerance { 1 }
    capacity { 1 }
  end
end
