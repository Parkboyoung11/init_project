User.create!(name: "Adagaki Aki",
             email: "aki@yopmail.com",
             password: "aki2412",
             password_confirmation: "aki2412",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

21.times do |n|
  name  = Faker::SwordArtOnline.game_name
  email = "user-#{n+1}@yopmail.com"
  password = "aki2412"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.all
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

5.times do
  title = Faker::SwordArtOnline.item
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(title: title, content: content) }
end

user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
