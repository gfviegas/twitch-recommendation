# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TRS.Repo.insert!(%TRS.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TRS.Games

games = [
  %{
    "twitch_id" => 509658,
    "name" => "Just Chatting",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Just%20Chatting-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 27471,
    "name" => "Minecraft",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Minecraft-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 18122,
    "name" => "World of Warcraft",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/World%20of%20Warcraft-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 21779,
    "name" => "League of Legends",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 32982,
    "name" => "Grand Theft Auto V",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Grand%20Theft%20Auto%20V-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 33214,
    "name" => "Fortnite",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 512710,
    "name" => "Call of Duty: Warzone",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/./Call%20of%20Duty:%20Warzone-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 510218,
    "name" => "Among Us",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Among%20Us-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 516575,
    "name" => "VALORANT",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/VALORANT-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 491931,
    "name" => "Escape From Tarkov",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Escape%20From%20Tarkov-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 511224,
    "name" => "Apex Legends",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Apex%20Legends-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 502732,
    "name" => "Garena Free Fire",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Garena%20Free%20Fire-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 512709,
    "name" => "Call of Duty: Black Ops Cold War",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/./Call%20of%20Duty:%20Black%20Ops%20Cold%20War-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 26936,
    "name" => "Music",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Music-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 32399,
    "name" => "Counter-Strike: Global Offensive",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/./Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 491487,
    "name" => "Dead by Daylight",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Dead%20by%20Daylight-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 138585,
    "name" => "Hearthstone",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Hearthstone-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 509660,
    "name" => "Art",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Art-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 23857,
    "name" => "Pokémon HeartGold/SoulSilver",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/Pok%C3%A9mon%20HeartGold/SoulSilver-{width}x{height}.jpg"
  },
  %{
    "twitch_id" => 1614555304,
    "name" => "Call Of Duty: Modern Warfare",
    "image_url" => "https://static-cdn.jtvnw.net/ttv-boxart/./Call%20Of%20Duty:%20Modern%20Warfare-{width}x{height}.jpg"
  }
]

Enum.each(games, fn entry -> Games.create_game(entry) end)
