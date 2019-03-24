FactoryBot.define do
  factory :guest do
    name { Faker::Name.name }
    event { nil }
    document { Faker::IDNumber.brazilian_citizen_number }
  end
end
