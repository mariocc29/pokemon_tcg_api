FactoryBot.define do
  factory :deck do
    label { Faker::Internet.slug }
    cards { 
      [{
        id: Faker::Alphanumeric.alpha(number: 10),
        name: Faker::Games::Pokemon.name,
        image: Faker::Internet.url(host: 'example.com', path: '/image.png')
      }]
    }

    trait :with_type_grass do
      category { "grass" }
    end

    trait :with_type_fire do
      category { "fire" }
    end

    trait :with_type_water do
      category { "water" }
    end
  end
end
