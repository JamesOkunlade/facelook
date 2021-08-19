# frozen_string_literal: true

# Generate Users
User.create!(first_name: 'Adnan',
             last_name: 'Afsari',
             email: 'adnanafsari.swe@gmail.com',
             password: 'password')

(1..15).each do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "user#{i}@mail.com"
  password = 'password'
  User.create!(first_name: first_name, last_name: last_name, email: email, password: password)
end

# Generate friendships
user = User.first
User.all.where.not(id: user.id).limit(10).each do |u|
  user.friends << u
  u.friends << user
end

# Generate Posts
User.take(5).each do |u|
  5.times do
    u.posts.create!(content: Faker::Lorem.paragraph_by_chars(number: 200))
  end
end

# Generate Comments
posts = Post.take(5)
User.take(5).each do |u|
  posts.each do |p|
    p.comments.create!(user: u, content: Faker::Lorem.paragraph_by_chars(number: 150))
  end
end

# Generate Likes
posts = Post.take(5)
User.take(6).each do |u|
  posts.each do |p|
    p.likes.create!(user: u)
  end
end
