include RandomData

FactoryGirl.define do

  factory :article do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    wiki 
  end

end
