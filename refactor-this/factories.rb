Factory.define(:profile) do |pr|
  pr.association :user
end

Factory.sequence(:email) do |n|
  "user-#{n}@example.com"
end

Factory.define(:user) do |u|
  u.association :photo
  u.association :profile
  u.name "Example User"
  u.email Factory.next(:email)
end

Factory.define(:photo) do |p|
  p.association :user
end