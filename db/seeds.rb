require 'faker'

3.times do
  User.create(
  name: Faker::Name.first_name,
  email: Faker::Internet.email,
)

end
