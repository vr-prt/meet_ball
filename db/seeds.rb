require 'faker'
require 'open-uri'
require "uri"
require "net/http"

puts "Deleting all the models..."
Badge.destroy_all
UserBadge.destroy_all
Result.destroy_all
Player.destroy_all
Game.destroy_all
Playground.destroy_all
Chatroom.destroy_all
User.destroy_all
puts "All the data deleted"
puts '--------------------------------'

puts '--------------------------------'
puts "Creating the main user..."
puts '--------------------------------'

main_user = User.create(username: "Player 1", email: "a@a.a", password: "meetball", rank: 0, rank_points: 0)

puts '--------------------------------'
puts "Main user #{main_user.username} created"
puts '--------------------------------'

second_user = User.create(username: "Player 2", email: "b@b.b", password: "meetball", rank: 3, rank_points: 100)

puts '--------------------------------'
puts "Main user #{second_user.username} created"
puts '--------------------------------'

chatroom = Chatroom.create(name: "general")

puts '--------------------------------'
puts "Chatroom #{chatroom.name} created"
puts '--------------------------------'

main_user_photo_url = "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/Shaq_sezxaw.png"

main_user_image = URI.open(main_user_photo_url)
main_user.photo.attach(io: main_user_image, filename: "#{main_user['username']}.png", content_type: "image/png")
main_user.save!
puts "Image given to #{main_user.email}"

second_user_photo_url = "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/VC_mryw8j.jpg"

second_user_image = URI.open(second_user_photo_url)
second_user.photo.attach(io: second_user_image, filename: "#{second_user['username']}.png", content_type: "image/png")
second_user.save!
puts "Image given to #{second_user.email}"


puts 'Creating badges...'


Badge::BADGES.each do |badge|
  new_badge = Badge.new(
    name: badge
  )

  def attach_photo(new_badge, url)
    badge_image = URI.open(url)
    new_badge.photo.attach(io: badge_image, filename: "#{new_badge['name']}.png", content_type: "image/png")
    new_badge.save!
  end

  case new_badge.name

    when "faiplay"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Team_Player_pebdby.png"
      attach_photo(new_badge, url)

    when "rebounder"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Rebouder_iddwwf.png"
      attach_photo(new_badge, url)

    when "sharpshoter"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868542/User%20Badges/Sharpshooter_drwco1.png"
      attach_photo(new_badge, url)

    when "mvp"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Game_MVP_ovqzr7.png"
      attach_photo(new_badge, url)

    when "playmaker"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Playmaker_krgav6.png"
      attach_photo(new_badge, url)

    when "dribble god"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Dribble_God_npkfwm.png"
      attach_photo(new_badge, url)
    else

      puts ""
      puts "Could not give image to new badge."
      puts ""

  end

  puts ""
  puts "created new badge: #{new_badge.name}"
  puts ""
end

  puts "Giving Badges to Main User"

  rand(3..5).times do
    user_badge = UserBadge.new

    user_badge.user = main_user
    user_badge.badge = Badge.all.sample
    user_badge.save!

    puts ""
    puts ""
    puts "User_badges #{user_badge.badge.name} given to #{main_user.username}"
    puts ""
    puts ""

  end


puts "Creating playgrounds..."

# playgrounds_api_url = 'https://storage.googleapis.com/dx-montreal/resources/2dac229f-6089-4cb7-ab0b-eadc6a147d5d/terrain_sport_ext.json'
# playgrounds_api_serialized = URI.open(playgrounds_api_url).read
# playgrounds_api = JSON.parse(playgrounds_api_serialized)

# playgrounds_api["features"].each do |record|
#   if record["properties"]["NOM"].include?("Basketball")
#     Playground.create(
#       name:
#     )
#   end
# end

 avatar_url = [
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/AI_pub3zu.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Jordan_dqcfsp.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Curry_ona8v3.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Kobe_n9ovsn.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Lebron_xyan6e.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/KG_hkopdc.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/Tatum_lvqoh2.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Curry_ona8v3.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Jordan_dqcfsp.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Durant_cgbjbj.jpg"
]

avatar_url.each do |url|

  user = User.create(
    username: Faker::Internet.username(specifier: 10),
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    rank: rand(0..5),
    rank_points: rand(0..100)
  )

  user_image = URI.open(url)
  user.photo.attach(io: user_image, filename: "#{user['username']}.png", content_type: "image/png")
  user.save!

  puts ""
  puts "user: #{user.username} created with image"
  puts ""
end


# create users 10


def read_and_parse_url(url)
  playgrounds_api_serialized = URI.open(url).read
  JSON.parse(playgrounds_api_serialized)
end

# create playgrounds

def build_playground(main_user, json)

  excluded_addresses = [
    "2463 Rue West Broadway, Montréal, QC H4B 1K1, Canada",
    "7505 Bd Provencher, Montréal, QC H1S 2Y8, Canada",
    "4755 Rue Jarry E Ste 200C, Montreal, Quebec H1R 1X7, Canada",
    "4510 Rue West Broadway, Montréal, QC H4B 2A8, Canada"
  ]

  json["results"].each do |result|
    if result["photos"] && !excluded_addresses.include?(result["formatted_address"])
      playground = Playground.create(
        name: result["name"],
        address: result["formatted_address"],
        latitude: result["geometry"]["location"]["lat"],
        longitude: result["geometry"]["location"]["lng"]
      )

      puts "Playground #{playground.name} successfully created"

      photo_reference = result["photos"][0]["photo_reference"]
      photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=#{photo_reference}&key=#{ENV['GMAPS_API']}"

      puts "Playground image url = #{photo_url}"

      playground_image = URI.open(photo_url)
      playground.photo.attach(io: playground_image, filename: "#{playground['name']}.png", content_type: "image/png")

      puts "Image given to #{playground.name}"

    end
  end
end

def create_playgrounds_from_url(main_user, url)
  json = read_and_parse_url(url)
  build_playground(main_user, json)
  return json["next_page_token"]
end

playgrounds_api_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=terrain%20de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(main_user, playgrounds_api_url)

playgrounds_api_url2 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%20de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(main_user, playgrounds_api_url2)

playgrounds_api_url3 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(main_user, playgrounds_api_url3)

playgrounds_api_url4 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(main_user, playgrounds_api_url4)

playgrounds_api_url5 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(main_user, playgrounds_api_url5)

# create games for the main_user

games_of_main_user = []

5.times do
  game = Game.new(
    start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now + 4, format: :default),
    end_date: Faker::Time.between(from: DateTime.now + 2, to: DateTime.now + 4, format: :default),
    game_mode: rand(0..1),
    team_size: rand(1..3)
  )

  start_date = game.start_date

  game.end_date = start_date + 1.hour

  game.user = main_user
  game.playground = Playground.all.sample
  game.save!

  games_of_main_user << game
end

# give players to main_user's games

games_of_main_user.each do |game|
  enum = game.team_size.to_i
  number_of_players = enum * 2

  puts "inside main user game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

  # creating players for the blue team

  if (enum == 1)
    player = User.all.sample
      until game.players.include?(player)
        Player.create(
          user: player,
          confirmed_results: [true, false].sample,
          team: 1,
          game: game
        )
      end

    puts "player: #{player.user.username} saved!"

  else
    (enum - 1).times do
      player = User.all.sample
      unless game.players.include?(player)
        Player.create(
          user: player,
          confirmed_results: [true, false].sample,
          team: 1,
          game: game
        )
      end

      puts "player of the blue team: #{player} saved!"
    end
  end

  # creating players for the red team

  (enum - rand(0..1)).times do
    player = User.all.sample
      until game.players.include?(player)
        Player.create(
          user: player,
          confirmed_results: [true, false].sample,
          team: 0,
          game: game
        )
      end

    puts "player of the red team: #{player.user.username} saved!"
  end
end

# give games to all playgrounds

Playground.all.each do |playground|


  playground_games = []

  3.times do
    game = Game.new(
      start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now + 4, format: :default),
      end_date: Faker::Time.between(from: DateTime.now + 2, to: DateTime.now + 4, format: :default),
      game_mode: rand(0..1),
      team_size: rand(1..3)
    )

    start_date = game.start_date

    game.end_date = start_date + 1.hour

    game.user = User.all.sample
    game.playground = playground
    game.save!

    playground_game << game
  end

  playground_games.each do |game|
    enum = game.team_size.to_i
    number_of_players = enum * 2

    puts "inside main user game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

    # creating players for the blue team

    if (enum == 1)
      player = User.all.sample
        until game.players.include?(player)
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 1,
            game: game
          )
        end

      puts "player of the blue team: #{player.user.username} saved!"

    else
      (enum - 1).times do
        player = User.all.sample
        until game.players.include?(player) || game.players.length == enum
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 1,
            game: game
          )
        end

        puts "player of the blue team: #{player.user.username} saved!"
      end
    end

    # creating players for the red team

    (enum - rand(0..1)).times do
      player = User.all.sample
        until game.players.include?(player) || game.players.length == enum
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 0,
            game: game
          )
        end

      puts "player of the red team: #{player.user.username} saved!"
    end
  end
end


puts '--------------------------------'
puts ""
puts '--------------------------------'

puts "Seed completed with success"

puts '--------------------------------'






# games = []

# rand(1..3).times do
#   game = Game.new(
#     start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now + 4, format: :default),
#     end_date: Faker::Time.between(from: DateTime.now + 2, to: DateTime.now + 4, format: :default),
#     game_mode: rand(0..1),
#     team_size: rand(0..2)
#   )

#   start_date = game.start_date

#   game.end_date = start_date + 1.hour

#   game.user = user
#   game.playground = playground
#   game.save!

#   games << game
# end

# games.each do |game|
#   puts "Successfully created a #{game.game_mode == 0 ? 'Competitive' : 'Casual'} game starting at #{game.start_date} to #{game.end_date}"
# end

# puts '--------------------------------'

# players = []
# players_who_confirmed = []

# games.each do |game|
#   enum = game.team_size.to_i
#   number_of_players = enum * 2

#   puts "inside game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

#   if (enum == 1)
#     player = Player.new(
#       confirmed_results: [true, false].sample,
#       team: 1
#     )

#     player.user = user
#     player.game = game
#     player.save!

#     players << player

#     puts "player saved!"

#   else
#     (enum - 1).times do
#       player = Player.new(
#         confirmed_results: [true, false].sample,
#         team: 1
#       )

#       player.user = [User.second, User.third, User.fourth].sample
#       player.game = game
#       player.save!

#       players << player

#       puts "player saved!"
#     end
#   end

#   (enum - rand(0..1)).times do
#     player = Player.new(
#       confirmed_results: [true, false].sample,
#       team: 0
#     )

#     player.user = [User.fifth, User.last].sample
#     player.game = game
#     player.save!

#     players << player

#     puts "player saved!"
#   end
# end

# puts "games.each do. done."

# players.each do |player|
#   puts "Successfully created player in team: #{player.team == 0 ? 'Red' : 'Blue'}. The player has #{player.confirmed_results ? 'Confirmed' : 'Not confirmed'} game results."
#   puts "Attributed to game starting #{player.game.start_date}. Same player is user #{player.user.username}."

#   puts '--------------------------------'

#   if player.confirmed_results?
#     players_who_confirmed << player
#   end
# end

# if (players.length / 2).to_f > players_who_confirmed.length
#   status = 0
# else
#   status = 1
# end

# result = Result.new(
#   red_score: [20..50].sample,
#   blue_score: [20..50].sample,
#   status: status
# )

# result.game = games.sample
# result.save!

# puts "Successfully created results for game: #{result.game}."
# puts "#{players_who_confirmed.length} players confirmed the game results. Results are #{result.status == 0 ? "Confirmed" : "Not confirmed"}."

# puts "creating badges"
# puts "---------------------------------------------------"

# rand(3..5).times do
#   user_badge = UserBadge.new

#   user_badge.user = user
#   user_badge.badge = Badge.all.sample
#   user_badge.save!

#   puts ""
#   puts ""
#   puts "User_badges given to user"
#   puts ""
#   puts ""
# end
