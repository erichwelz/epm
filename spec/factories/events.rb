FactoryGirl.define do

  factory :event do
    start { rand(100).days.from_now.change hour: rand(7..19) }
    duration { rand(1..5).hours }

    factory :participatable_event do
      coordinator
    end

    factory :full_event do
      name { Faker::Lorem.words(rand 2..5).join(' ').capitalize }
      description { Faker::Lorem.sentences(rand 1..5).join(' ') }
    end

  end

  factory :past_event, class: Event do
    start { (rand(100)+1).days.ago.change hour: rand(7..19) }
    duration { rand(1..5).hours }

    factory :full_past_event do
      name { Faker::Lorem.words(rand 2..5).join(' ').capitalize }
      description { Faker::Lorem.sentences(rand 1..5).join(' ') }
    end

    factory :participatable_past_event do
      coordinator
    end

  end

end