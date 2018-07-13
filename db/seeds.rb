User.create!(name: "Adagaki Aki",
             email: "aki@yopmail.com",
             password: "aki2412",
             password_confirmation: "aki2412",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
