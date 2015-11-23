FactoryGirl.define do
  factory :wiki do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph(6)
    private false
    user 
  end

end
