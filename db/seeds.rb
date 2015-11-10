# ##############################################################
# Create Users (Standard)
# ##############################################################

7.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(10)
    role: 0
  )
end

users = User.all

# ##############################################################
# Create Public Wikis
# ##############################################################

20.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence(100)
    user: users.
  )
end
