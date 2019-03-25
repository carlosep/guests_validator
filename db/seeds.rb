5.times do
  date = Faker::Date.forward(2)
  Event.create!(name: Faker::Lorem.sentence,
                starts_at: date + 2.hours,
                ends_at: date + 5.hours,
                tolerance: Faker::Number.between(10, 20),
                capacity: Faker::Number.between(100, 500))
end

statuses = %w[late early on_time]

Event.all.each do |event|
  10.times do
    Guest.create!(event_id: event.id,
                  name: Faker::Name.name,
                  document: Faker::IDNumber.brazilian_citizen_number,
                  status: statuses.sample)
  end
end
