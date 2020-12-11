defmodule TRS.Streams do
  alias TRS.TwitchClient
  alias TRS.Interests

  alias TRS.Accounts.User

  def list_streams(game_ids \\ [])
  def list_streams(game_ids) when is_list(game_ids) do
    TwitchClient.fetch_streams(game_ids)
  end

  def list_streams(%User{id: user_id}) do
    # Busca a lista de jogos de interesse do usuario
    game_ids = Interests.list_user_interests(user_id)
      |> Enum.map(&(&1.game_id))
      |> Enum.uniq

    TwitchClient.fetch_streams(game_ids)
  end

end
