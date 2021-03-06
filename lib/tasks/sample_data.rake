namespace :db do
  desc "Fill in database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Tawheed",
                         email: "tawrahim@gmail.com",
                         password: "123456",
                         password_confirmation: "123456")
    admin.toggle!(:admin)
    30.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@me.org"
      password = "password"
      User.create!(name: name, email: email, password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each do |user|
        user.goals.create!(content: content) 
      end
    end

  end
end
