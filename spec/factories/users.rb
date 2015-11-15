FactoryGirl.define do
  pw = Faker::Internet.password(10)

  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw  
  end

end
