include RandomData

FactoryGirl.define do
  factory :wiki do
    title RandomData.random_sentence
    description RandomData.random_sentence
    private false
    user 
  end

end
