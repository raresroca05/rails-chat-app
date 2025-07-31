# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample users
alice = User.find_or_create_by!(email: "alice@example.com") do |user|
  user.display_name = "Alice"
  user.password = "password123"
  user.password_confirmation = "password123"
end

bob = User.find_or_create_by!(email: "bob@example.com") do |user|
  user.display_name = "Bob"
  user.password = "password123"
  user.password_confirmation = "password123"
end

charlie = User.find_or_create_by!(email: "charlie@example.com") do |user|
  user.display_name = "Charlie"
  user.password = "password123"
  user.password_confirmation = "password123"
end

# Create sample chat rooms
general = ChatRoom.find_or_create_by!(name: "General")
tech = ChatRoom.find_or_create_by!(name: "Tech Talk")
random = ChatRoom.find_or_create_by!(name: "Random")

# Add users to chat rooms
general.add_member(alice)
general.add_member(bob)
general.add_member(charlie)

tech.add_member(alice)
tech.add_member(bob)

random.add_member(bob)
random.add_member(charlie)

# Create some sample messages
if general.messages.empty?
  general.messages.create!(user: alice, content: "Welcome to the general chat!")
  general.messages.create!(user: bob, content: "Hey everyone! Great to be here.")
  general.messages.create!(user: charlie, content: "This is a nice chat app!")
end

if tech.messages.empty?
  tech.messages.create!(user: alice, content: "Anyone working on Rails projects?")
  tech.messages.create!(user: bob, content: "Yes! Just finished implementing real-time features with Turbo Streams.")
end

if random.messages.empty?
  random.messages.create!(user: bob, content: "What's everyone's favorite programming language?")
  random.messages.create!(user: charlie, content: "I really like Ruby for its expressiveness!")
end

puts "Created #{User.count} users"
puts "Created #{ChatRoom.count} chat rooms"
puts "Created #{Message.count} messages"
puts "Created #{RoomMembership.count} room memberships"
