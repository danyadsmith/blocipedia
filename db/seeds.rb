# ##############################################################
# Create Users (10)
# ##############################################################

7.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(10),
    role: 0
  )
end

standard_user = User.create!(
  email: "standard@blocipedia.com",
  password: "blocipedia",
  role: 0
)

premium_user = User.create!(
  email: "premium@blocipedia.com",
  password: "blocipedia",
  role: 1
)

admin_user = User.create!(
  email: "admin@blocipedia.com",
  password: "blocipedia",
  role: 2
)

users = User.all

# ##############################################################
# Create Public Wikis (20)
# ##############################################################

20.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence(3),
    user: users.sample,
    private: false
  )
  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

public_wikis = Wiki.where(private: false)

# ##############################################################
# Create Public Wiki Articles (100)
# ##############################################################

100.times do 
  article = Article.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(100),
    wiki: public_wikis.sample
  )
  article.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

# ##############################################################
# Create Private Wikis (5)
# ##############################################################

5.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence(3),
    user: users[rand(8..9)],
    private: true
  )
  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

private_wikis = Wiki.where(private: true)

# ##############################################################
# Create Private Wiki Articles (100)
# ##############################################################

100.times do 
  article = Article.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(100),
    wiki: private_wikis.sample
  )
  article.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end