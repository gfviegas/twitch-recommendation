defmodule TRS.Streams do
  alias TRS.Streams.Stream

  # TODO: Bater na api da twitch pra retornar estes dados
  def list_streams do
    [
      %Stream{id: 1, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 27471, title: "Joguinho da quebrada", viewer_count: 10, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"},
      %Stream{id: 2, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 18122, title: "TO alone venham me ver", viewer_count: 5, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"},
      %Stream{id: 3, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 18122, title: "TO alone venham me ver", viewer_count: 5, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"},
      %Stream{id: 4, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 18122, title: "TO alone venham me ver", viewer_count: 5, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"},
      %Stream{id: 5, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 18122, title: "TO alone venham me ver", viewer_count: 5, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"},
      %Stream{id: 6, user_id: 23090, user_name: "JOaozinho Gameplay", game_name: "Minecraft", game_id: 18122, title: "TO alone venham me ver", viewer_count: 5, thumbnail_url: "https://static-cdn.jtvnw.net/previews-ttv/live_user_dansgaming-1280x720.jpg"}
    ]
  end

  def list_streams(current_user) do
    # Busca a lista de jogos de interesse do usuario

    # Bater na api passando os game_ids vinculados a este usuario
    nil
  end

  def get_stream!(id) do
    nil
  end

end
