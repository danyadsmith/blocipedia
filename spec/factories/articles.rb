FactoryGirl.define do

  factory :article do
    title Faker::Lorem.sentence(1)
    body Faker::Lorem.paragraph(6, true)
    wiki 
  end

end
